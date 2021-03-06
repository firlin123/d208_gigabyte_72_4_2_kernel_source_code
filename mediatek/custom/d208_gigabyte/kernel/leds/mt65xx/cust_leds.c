#include <cust_leds.h>
#include <mach/mt_pwm.h>

#include <linux/kernel.h>
#include <mach/pmic_mt6329_hw_bank1.h> 
#include <mach/pmic_mt6329_sw_bank1.h> 
#include <mach/pmic_mt6329_hw.h>
#include <mach/pmic_mt6329_sw.h>
#include <mach/upmu_common_sw.h>
#include <mach/upmu_hw.h>

//extern int mtkfb_set_backlight_level(unsigned int level);
//extern int mtkfb_set_backlight_pwm(int div);
extern int disp_bls_set_backlight(unsigned int level);
/*
#define ERROR_BL_LEVEL 0xFFFFFFFF

unsigned int brightness_mapping(unsigned int level)
{  
	return ERROR_BL_LEVEL;
}
*/
unsigned int brightness_mapping(unsigned int level)
{
    unsigned int mapped_level;
    //zhoulidong modify 
    mapped_level = (level+1)/4;
//    mapped_level = level;      
	return mapped_level;
}

unsigned int Cust_SetBacklight(int level, int div)
{
    //mtkfb_set_backlight_pwm(div);
    //mtkfb_set_backlight_level(brightness_mapping(level));
    disp_bls_set_backlight(brightness_mapping(level));
    return 0;
}

//++++rgk bug_id: null add by jiangwanwei 130210 start++++
#if 1
extern int FL_enable(void);
extern int FL_disable(void);
int flash_set(unsigned int level)
{
	if(level)
		FL_enable();
	else
		FL_disable();
	return 0;
}
#endif
//++++rgk bug_id: null add by jiangwanwei 130210 end++++

static struct cust_mt65xx_led cust_led_list[MT65XX_LED_TYPE_TOTAL] = {
	{"red",               MT65XX_LED_MODE_NONE, -1, {0}},
	{"green",             MT65XX_LED_MODE_NONE, -1, {0}},
	{"blue",              MT65XX_LED_MODE_NONE, -1, {0}},
	{"jogball-backlight", MT65XX_LED_MODE_NONE, -1, {0}},
	{"keyboard-backlight",MT65XX_LED_MODE_NONE, -1, {0}},
	{"button-backlight",  MT65XX_LED_MODE_PMIC, MT65XX_LED_PMIC_NLED_ISINK1, {0}},
// zhoulidong moidify
	{"lcd-backlight",     MT65XX_LED_MODE_PWM, PWM2, {1,0,32,32,0}},
//	{"lcd-backlight",     MT65XX_LED_MODE_PMIC, MT65XX_LED_PMIC_LCD_ISINK, {0}},
	{"flash", 		MT65XX_LED_MODE_GPIO, flash_set, {0}},				//++++rgk bug_id: null add by jiangwanwei 130210++++
};

struct cust_mt65xx_led *get_cust_led_list(void)
{
	return cust_led_list;
}

