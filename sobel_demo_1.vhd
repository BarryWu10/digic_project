
-- 
-- Definition of  sobel_demo
-- 
--      Wed May 10 17:37:56 2017
--      
--      LeonardoSpectrum Level 3, 2008b.3
-- 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
library adk;
use adk.adk_components.all;

entity sobel_demo is
   port (
      i_clock : IN std_logic ;
      i_valid : IN std_logic ;
      i_pixel_top : IN std_logic_vector (23 DOWNTO 0) ;
      i_pixel_mid : IN std_logic_vector (23 DOWNTO 0) ;
      i_pixel_bot : IN std_logic_vector (23 DOWNTO 0) ;
      i_reset : IN std_logic ;
      o_edge : OUT std_logic ;
      o_dir : OUT std_logic_vector (2 DOWNTO 0) ;
      o_valid : OUT std_logic ;
      o_mode : OUT std_logic_vector (1 DOWNTO 0)) ;
end sobel_demo ;

architecture Structural of sobel_demo is
   signal o_edge_dup0, o_mode_dup0_1, o_mode_dup0_0, nx2270, 
      derivative_state, nx2, nx14, nx22, nx30, nx38, nx46, nx54, nx62, nx76, 
      nx82, nx90, nx98, nx106, nx138, nx152, nx160, nx168, nx178, nx188, 
      nx198, nx212, nx222, nx236, nx246, nx250, nx264, nx280, nx288, nx290, 
      nx298, nx306, nx314, nx322, nx324, nx326, nx358, nx372, nx380, nx388, 
      nx398, nx406, nx412, nx416, nx424, nx426, nx432, nx436, nx444, nx446, 
      nx452, nx456, nx462, nx466, nx472, nx480, nx490, nx494, nx498, nx506, 
      nx514, nx522, nx540, nx548, nx550, nx554, w_D_NW_SE_9, nx568, 
      w_D_NW_SE_8, nx584, w_D_NW_SE_7, nx600, w_D_NW_SE_6, nx616, 
      w_D_NW_SE_5, nx632, w_D_NW_SE_4, nx648, w_D_NW_SE_3, nx664, 
      w_D_NW_SE_2, nx680, w_D_NW_SE_1, nx696, w_D_NW_SE_0, nx724, nx732, 
      nx734, nx736, nx738, nx740, nx742, nx744, nx746, nx748, nx750, nx756, 
      w_D_NW_SE_10, nx764, nx778, nx784, nx792, nx800, nx808, nx816, nx824, 
      nx832, nx846, nx852, nx860, nx868, nx876, nx908, nx922, nx930, nx938, 
      nx948, nx958, nx968, nx982, nx992, nx1006, nx1016, nx1020, nx1034, 
      nx1050, nx1060, nx1068, nx1076, nx1084, nx1092, nx1094, nx1096, nx1128, 
      nx1142, nx1150, nx1158, nx1168, nx1176, nx1182, nx1186, nx1194, nx1196, 
      nx1202, nx1206, nx1214, nx1216, nx1222, nx1226, nx1232, nx1236, nx1242, 
      nx1250, nx1260, nx1264, nx1268, nx1276, nx1284, nx1292, nx1310, nx1318, 
      nx1320, nx1324, w_D_NE_SW_1, nx1338, w_D_NE_SW_0, nx1366, nx1374, 
      nx1376, nx1382, w_D_NE_SW_3, nx1388, w_D_NE_SW_2, nx1404, nx1416, 
      nx1418, nx1424, w_D_NE_SW_5, nx1440, w_D_NE_SW_4, nx1456, nx1468, 
      nx1470, nx1476, nx1482, nx1488, w_D_NE_SW_8, nx1500, w_D_NE_SW_7, 
      nx1516, w_D_NE_SW_6, nx1532, nx1544, nx1546, nx1548, nx1554, nx1560, 
      nx1566, w_D_NE_SW_10, nx1578, w_D_NE_SW_9, nx1596, nx1608, nx1610, 
      nx1616, nx1622, nx1630, nx1636, nx1644, nx1652, nx1660, nx1668, nx1676, 
      nx1684, nx1698, nx1704, nx1712, nx1720, nx1728, nx1760, nx1774, nx1782, 
      nx1790, nx1800, nx1810, nx1820, nx1834, nx1844, nx1858, nx1868, nx1872, 
      nx1886, nx1902, nx1910, nx1912, nx1920, nx1928, nx1936, nx1944, nx1946, 
      nx1948, nx1980, nx1994, nx2002, nx2010, nx2020, nx2028, nx2034, nx2038, 
      nx2046, nx2048, nx2054, nx2058, nx2066, nx2068, nx2074, nx2078, nx2084, 
      nx2088, nx2094, nx2102, nx2112, nx2116, nx2120, nx2128, nx2136, nx2144, 
      nx2162, nx2170, nx2172, nx2176, w_D_N_S_10, nx2192, w_D_N_S_9, nx2210, 
      w_D_N_S_8, nx2226, w_D_N_S_7, nx2242, w_D_N_S_6, nx2258, w_D_N_S_5, 
      nx2274, w_D_N_S_4, nx2290, w_D_N_S_3, nx2306, w_D_N_S_2, nx2322, 
      w_D_N_S_1, nx2338, w_D_N_S_0, nx2366, nx2374, nx2376, nx2378, nx2380, 
      nx2382, nx2384, nx2386, nx2388, nx2390, nx2392, nx2394, nx2404, nx2414, 
      nx2424, nx2434, nx2444, nx2454, nx2464, nx2468, nx2474, nx2478, nx2484, 
      nx2488, nx2494, nx2510, nx2526, nx2542, nx2558, nx2574, nx2590, nx2598, 
      nx2604, nx2610, nx2618, nx2626, nx2634, nx2642, nx2650, nx2658, nx2672, 
      nx2678, nx2686, nx2694, nx2702, nx2734, nx2748, nx2756, nx2764, nx2774, 
      nx2784, nx2794, nx2808, nx2818, nx2832, nx2842, nx2846, nx2860, nx2876, 
      nx2886, nx2894, nx2902, nx2910, nx2918, nx2920, nx2922, nx2954, nx2968, 
      nx2976, nx2984, nx2994, nx3002, nx3008, nx3012, nx3020, nx3022, nx3028, 
      nx3032, nx3040, nx3042, nx3048, nx3052, nx3058, nx3062, nx3068, nx3076, 
      nx3086, nx3090, nx3094, nx3102, nx3110, nx3118, nx3136, nx3144, nx3146, 
      nx3150, w_D_E_W_10, nx3166, w_D_E_W_9, nx3184, w_D_E_W_8, nx3200, 
      w_D_E_W_7, nx3216, w_D_E_W_6, nx3232, w_D_E_W_5, nx3248, w_D_E_W_4, 
      nx3264, w_D_E_W_3, nx3280, w_D_E_W_2, nx3296, w_D_E_W_1, nx3312, 
      w_D_E_W_0, nx3340, nx3348, nx3350, nx3352, nx3354, nx3356, nx3358, 
      nx3360, nx3362, nx3364, nx3366, nx3368, nx3380, nx3388, nx3400, nx3408, 
      nx3420, nx3428, nx3440, nx3448, nx3460, nx3468, nx3480, nx3488, nx3500, 
      nx3508, nx3520, nx3528, nx3540, nx3548, nx3560, nx3568, nx3580, nx3612, 
      nx3628, nx3644, nx3660, nx3676, nx3696, nx3704, nx3710, nx3716, nx3724, 
      nx3730, nx3738, nx3744, nx3750, nx3758, nx3764, nx3770, nx3778, nx3784, 
      nx3790, nx3798, nx3804, nx3810, nx3818, nx3824, nx3830, nx3838, nx3844, 
      nx3850, nx3858, nx3864, nx3870, nx3878, nx3884, nx3890, nx3898, nx3904, 
      nx3918, nx3926, nx3942, nx3958, nx3974, nx3990, nx4006, nx4024, nx4032, 
      nx4036, nx4040, nx4046, nx4076, nx4084, nx4102, nx4134, nx4146, nx4158, 
      nx4176, nx4182, nx4202, nx4220, nx4232, nx4236, nx4242, nx4248, nx4252, 
      nx4260, nx4272, nx4280, nx4284, nx4304, nx4316, nx4330, nx4336, nx4344, 
      nx4346, nx4348, nx4350, nx4360, nx4388, nx4400, nx4408, nx4430, nx4440, 
      nx4452, nx4478, nx4488, nx4500, nx4530, nx4540, nx4552, nx4578, nx4588, 
      nx4600, nx4608, nx4610, nx4620, w_dbusy, nx4634, state_1, nx4652, 
      nx4658, nx4664, nx4674, nx2357, nx2367, nx2377, nx2387, nx2397, nx2407, 
      nx2417, nx2427, nx2437, nx2447, nx2457, nx2467, nx2477, nx2487, nx2497, 
      nx2507, nx2517, nx2527, nx2537, nx2547, nx2557, nx2567, nx2577, nx2587, 
      nx2597, nx2607, nx2617, nx2627, nx2637, nx2647, nx2657, nx2667, nx2677, 
      nx2687, nx2697, nx2707, nx2717, nx2727, nx2737, nx2747, nx2757, nx2767, 
      nx2777, nx2787, nx2797, nx2807, nx2817, nx2827, nx2837, nx2847, nx2857, 
      nx2871, nx2885, nx2887, nx2895, nx2907, nx2911, nx2919, nx2923, nx2929, 
      nx2933, nx2939, nx2941, nx2943, nx2947, nx2949, nx2955, nx2957, nx2961, 
      nx2967, nx2973, nx2975, nx2977, nx2981, nx2983, nx2985, nx2989, nx2991, 
      nx2999, nx3001, nx3003, nx3005, nx3011, nx3013, nx3015, nx3017, nx3021, 
      nx3023, nx3031, nx3033, nx3035, nx3037, nx3043, nx3047, nx3049, nx3053, 
      nx3055, nx3057, nx3061, nx3063, nx3069, nx3071, nx3079, nx3093, nx3099, 
      nx3101, nx3105, nx3107, nx3113, nx3115, nx3121, nx3127, nx3129, nx3133, 
      nx3135, nx3137, nx3143, nx3145, nx3149, nx3151, nx3153, nx3157, nx3161, 
      nx3165, nx3171, nx3175, nx3177, nx3183, nx3187, nx3192, nx3195, nx3199, 
      nx3201, nx3205, nx3208, nx3211, nx3213, nx3217, nx3223, nx3227, nx3235, 
      nx3239, nx3243, nx3247, nx3253, nx3256, nx3263, nx3267, nx3272, nx3275, 
      nx3279, nx3283, nx3289, nx3291, nx3295, nx3297, nx3301, nx3305, nx3311, 
      nx3313, nx3317, nx3320, nx3325, nx3329, nx3337, nx3341, nx3345, nx3349, 
      nx3355, nx3357, nx3359, nx3363, nx3365, nx3371, nx3373, nx3377, nx3383, 
      nx3389, nx3391, nx3393, nx3399, nx3401, nx3405, nx3407, nx3413, nx3415, 
      nx3417, nx3421, nx3423, nx3425, nx3427, nx3431, nx3433, nx3441, nx3443, 
      nx3445, nx3447, nx3453, nx3457, nx3459, nx3463, nx3465, nx3467, nx3471, 
      nx3473, nx3479, nx3481, nx3489, nx3501, nx3507, nx3509, nx3513, nx3515, 
      nx3521, nx3523, nx3527, nx3529, nx3535, nx3537, nx3541, nx3543, nx3545, 
      nx3553, nx3555, nx3559, nx3561, nx3563, nx3567, nx3571, nx3575, nx3581, 
      nx3585, nx3587, nx3593, nx3597, nx3601, nx3603, nx3609, nx3611, nx3615, 
      nx3619, nx3621, nx3623, nx3627, nx3633, nx3637, nx3645, nx3649, nx3655, 
      nx3659, nx3665, nx3669, nx3677, nx3681, nx3687, nx3691, nx3697, nx3701, 
      nx3707, nx3709, nx3713, nx3715, nx3719, nx3725, nx3729, nx3731, nx3735, 
      nx3739, nx3743, nx3749, nx3753, nx3757, nx3761, nx3765, nx3769, nx3775, 
      nx3783, nx3789, nx3791, nx3797, nx3799, nx3801, nx3803, nx3807, nx3813, 
      nx3819, nx3823, nx3825, nx3829, nx3833, nx3839, nx3841, nx3843, nx3847, 
      nx3849, nx3853, nx3859, nx3863, nx3865, nx3867, nx3873, nx3875, nx3879, 
      nx3885, nx3887, nx3889, nx3891, nx3895, nx3897, nx3899, nx3901, nx3905, 
      nx3913, nx3915, nx3917, nx3919, nx3923, nx3925, nx3927, nx3929, nx3933, 
      nx3941, nx3945, nx3947, nx3953, nx3955, nx3961, nx3963, nx3971, nx3983, 
      nx3985, nx3989, nx3991, nx3997, nx3999, nx4005, nx4013, nx4017, nx4019, 
      nx4021, nx4028, nx4031, nx4035, nx4037, nx4039, nx4043, nx4047, nx4055, 
      nx4057, nx4059, nx4061, nx4067, nx4069, nx4071, nx4073, nx4079, nx4083, 
      nx4085, nx4089, nx4095, nx4099, nx4103, nx4109, nx4113, nx4117, nx4123, 
      nx4127, nx4131, nx4137, nx4141, nx4145, nx4151, nx4155, nx4159, nx4165, 
      nx4169, nx4173, nx4179, nx4183, nx4189, nx4197, nx4201, nx4207, nx4211, 
      nx4215, nx4217, nx4223, nx4225, nx4231, nx4233, nx4239, nx4243, nx4247, 
      nx4255, nx4259, nx4263, nx4267, nx4271, nx4275, nx4279, nx4283, nx4287, 
      nx4295, nx4303, nx4309, nx4315, nx4319, nx4323, nx4327, nx4329, nx4337, 
      nx4343, nx4345, nx4351, nx4353, nx4355, nx4359, nx4361, nx4365, nx4367, 
      nx4371, nx4375, nx4381, nx4385, nx4389, nx4393, nx4397, nx4401, nx4405, 
      nx4409, nx4413, nx4417, nx4419, nx4425, nx4427, nx4433, nx4435, nx4441, 
      nx4443, nx4447, nx4453, nx4459, nx4497, nx4501, nx4505, nx4507, nx4511, 
      nx4513, nx4519, nx4521, nx4525, nx4527, nx4533, nx4535, nx4539, nx4541, 
      nx4547, nx4549, nx4553, nx4555, nx4561, nx4563, nx4567, nx4569, nx4575, 
      nx4577, nx4579, nx4583, nx4589, nx4595, nx4601, nx4607, nx4613, nx4617, 
      nx4619, nx4625, nx4627, nx4631, nx4635, nx4639, nx4642, nx4644, nx4647, 
      nx4651, nx4656, nx4659, nx4661, nx4665, nx4667, nx4671, nx4677, nx4681, 
      nx4683, nx4685, nx4690, nx4692, nx4695, nx4700, nx4702, nx4704, nx4706, 
      nx4710, nx4712, nx4714, nx4716, nx4719, nx4724, nx4726, nx4728, nx4730, 
      nx4734, nx4736, nx4738, nx4740, nx4743, nx4748, nx4751, nx4753, nx4757, 
      nx4759, nx4763, nx4765, nx4771, nx4779, nx4781, nx4784, nx4786, nx4790, 
      nx4792, nx4797, nx4802, nx4805, nx4807, nx4809, nx4814, nx4817, nx4819, 
      nx4821, nx4824, nx4831, nx4833, nx4835, nx4837, nx4841, nx4843, nx4845, 
      nx4847, nx4851, nx4854, nx4858, nx4861, nx4863, nx4867, nx4870, nx4875, 
      nx4878, nx4881, nx4885, nx4888, nx4893, nx4897, nx4900, nx4902, nx4906, 
      nx4909, nx4914, nx4918, nx4922, nx4925, nx4929, nx4932, nx4934, nx4938, 
      nx4941, nx4946, nx4950, nx4954, nx4957, nx4961, nx4964, nx4966, nx4970, 
      nx4973, nx4978, nx4982, nx4986, nx4989, nx4993, nx4996, nx4998, nx5002, 
      nx5005, nx5007, nx5012, nx5017, nx5021, nx5024, nx5031, nx5038, nx5067, 
      nx5078, nx5081, nx5084, nx5092, nx5101, nx5107, nx5110, nx5113, nx5116, 
      nx5120, nx5123, nx5125, nx5127, nx5134, nx5137, nx5140, nx5142, nx5145, 
      nx5147, nx5152, nx5154, nx5156, nx5158, nx5161, nx5164, nx5166, nx5168, 
      nx5170, nx5172, nx5176, nx5181, nx5183, nx5185, nx5187, nx5195, nx5197, 
      nx5201, nx5203, nx5220, nx5224, nx5226, nx5244, nx5248, nx5252, nx5254, 
      nx5256, nx5264, nx5266, nx5268, nx5270, nx5272, nx5274, nx5276, nx5278, 
      nx5280, nx5282, nx5284, nx5286, nx5290, nx5294, nx5296, nx5298, nx5300, 
      nx5302, nx5304, nx5310, nx5312, nx5314, nx5316, nx5318, nx5, nx5322, 
      nx5325, nx5327, nx5329, nx5331, nx5333, nx5335, nx5337, nx5339, nx5341, 
      nx5343, nx5345, nx5347, nx5349, nx5351, nx5353, nx5355, nx5357, nx5359, 
      nx5361, nx5363, nx5365, nx5367, nx5369, nx5371, nx5373, nx5375, nx5377, 
      nx5383, nx5385: std_logic ;

begin
   o_edge <= o_edge_dup0 ;
   o_mode(1) <= o_mode_dup0_1 ;
   o_mode(0) <= o_mode_dup0_0 ;
   ix4611 : fake_vcc port map ( Y=>nx4610);
   ix2271 : fake_gnd port map ( Y=>nx2270);
   derivative_reg_o_valid : dffr port map ( Q=>o_valid, QB=>OPEN, D=>nx5226, 
      CLK=>i_clock, R=>i_reset);
   derivative_reg_state : dffr port map ( Q=>derivative_state, QB=>OPEN, D=>
      nx2, CLK=>i_clock, R=>i_reset);
   ix2872 : inv01 port map ( Y=>nx2871, A=>i_valid);
   reg_w_mode_0 : dffs_ni port map ( Q=>o_mode_dup0_0, QB=>OPEN, D=>nx2847, 
      CLK=>i_clock, S=>i_reset);
   ix2848 : mux21_ni port map ( Y=>nx2847, A0=>o_mode_dup0_0, A1=>nx4664, S0
      =>nx4674);
   reg_state_1 : dffs_ni port map ( Q=>state_1, QB=>OPEN, D=>nx2270, CLK=>
      i_clock, S=>i_reset);
   ix4653 : aoi21 port map ( Y=>nx4652, A0=>nx2885, A1=>state_1, B0=>nx2887
   );
   reg_state_0 : dffr port map ( Q=>OPEN, QB=>nx2885, D=>nx4652, CLK=>
      i_clock, R=>i_reset);
   derivative_reg_o_dbusy : dff port map ( Q=>w_dbusy, QB=>nx2887, D=>nx2837, 
      CLK=>i_clock);
   ix4675 : nand02 port map ( Y=>nx4674, A0=>nx2895, A1=>nx4658);
   reg_w_mode_1 : dffr port map ( Q=>o_mode_dup0_1, QB=>OPEN, D=>nx2857, CLK
      =>i_clock, R=>i_reset);
   ix2858 : or02 port map ( Y=>nx2857, A0=>o_mode_dup0_1, A1=>nx4674);
   ix4609 : mux21 port map ( Y=>nx4608, A0=>nx2907, A1=>nx5021, S0=>nx4400);
   ix2908 : mux21 port map ( Y=>nx2907, A0=>nx4452, A1=>nx4500, S0=>nx4408);
   ix4453 : nand02 port map ( Y=>nx4452, A0=>nx2911, A1=>nx5335);
   ix2912 : nand04 port map ( Y=>nx2911, A0=>nx4430, A1=>nx4440, A2=>nx3297, 
      A3=>nx3305);
   ix2920 : mux21 port map ( Y=>nx2919, A0=>w_D_E_W_8, A1=>nx3200, S0=>
      i_valid);
   ix3201 : xnor2 port map ( Y=>nx3200, A0=>nx2923, A1=>nx3002);
   ix2924 : mux21 port map ( Y=>nx2923, A0=>nx3008, A1=>nx3110, S0=>nx3012);
   ix3009 : xnor2 port map ( Y=>nx3008, A0=>nx2910, A1=>nx3043);
   ix2911 : mux21 port map ( Y=>nx2910, A0=>nx2929, A1=>nx2794, S0=>nx3035);
   ix2930 : mux21 port map ( Y=>nx2929, A0=>nx2902, A1=>nx3011, S0=>nx3017);
   ix2903 : mux21 port map ( Y=>nx2902, A0=>nx2933, A1=>nx2818, S0=>nx3003);
   ix2934 : mux21 port map ( Y=>nx2933, A0=>nx2894, A1=>nx2975, S0=>nx2985);
   ix2895 : mux21 port map ( Y=>nx2894, A0=>nx2842, A1=>nx2943, S0=>nx2846);
   ix2940 : nand02 port map ( Y=>nx2939, A0=>i_pixel_mid(16), A1=>
      i_pixel_bot(17));
   ix2942 : xnor2 port map ( Y=>nx2941, A0=>i_pixel_mid(17), A1=>
      i_pixel_bot(18));
   ix2944 : mux21 port map ( Y=>nx2943, A0=>nx2886, A1=>nx2955, S0=>nx2957);
   ix2887 : nand03 port map ( Y=>nx2886, A0=>nx2947, A1=>i_pixel_bot(16), A2
      =>nx2672);
   ix2948 : nand02 port map ( Y=>nx2947, A0=>nx2949, A1=>i_pixel_bot(0));
   ix2950 : inv01 port map ( Y=>nx2949, A=>i_pixel_top(16));
   ix2956 : oai21 port map ( Y=>nx2955, A0=>i_pixel_bot(17), A1=>
      i_pixel_mid(16), B0=>nx2939);
   ix2958 : xnor2 port map ( Y=>nx2957, A0=>nx2860, A1=>nx2955);
   ix2861 : xnor2 port map ( Y=>nx2860, A0=>nx2961, A1=>nx2658);
   ix2659 : xnor2 port map ( Y=>nx2658, A0=>i_pixel_bot(1), A1=>
      i_pixel_top(17));
   ix2847 : xnor2 port map ( Y=>nx2846, A0=>nx2967, A1=>nx2973);
   ix2968 : xnor2 port map ( Y=>nx2967, A0=>nx2678, A1=>nx2650);
   ix2679 : mux21 port map ( Y=>nx2678, A0=>i_pixel_top(17), A1=>nx2961, S0
      =>nx2658);
   ix2651 : xnor2 port map ( Y=>nx2650, A0=>i_pixel_bot(2), A1=>
      i_pixel_top(18));
   ix2974 : xnor2 port map ( Y=>nx2973, A0=>nx2939, A1=>nx2941);
   ix2976 : xnor2 port map ( Y=>nx2975, A0=>nx2977, A1=>nx2983);
   ix2978 : aoi32 port map ( Y=>nx2977, A0=>i_pixel_mid(16), A1=>
      i_pixel_bot(17), A2=>nx2734, B0=>i_pixel_bot(18), B1=>i_pixel_mid(17)
   );
   ix2982 : inv01 port map ( Y=>nx2981, A=>i_pixel_bot(18));
   ix2984 : xnor2 port map ( Y=>nx2983, A0=>i_pixel_mid(18), A1=>
      i_pixel_bot(19));
   ix2986 : xnor2 port map ( Y=>nx2985, A0=>nx2832, A1=>nx2975);
   ix2833 : xnor2 port map ( Y=>nx2832, A0=>nx2989, A1=>nx2642);
   ix2990 : aoi22 port map ( Y=>nx2989, A0=>nx2991, A1=>i_pixel_bot(2), B0=>
      nx2678, B1=>nx2650);
   ix2992 : inv01 port map ( Y=>nx2991, A=>i_pixel_top(18));
   ix2643 : xnor2 port map ( Y=>nx2642, A0=>i_pixel_bot(3), A1=>
      i_pixel_top(19));
   ix2819 : xnor2 port map ( Y=>nx2818, A0=>nx2748, A1=>nx3001);
   ix2749 : mux21 port map ( Y=>nx2748, A0=>nx2977, A1=>nx2999, S0=>nx2983);
   ix3000 : inv01 port map ( Y=>nx2999, A=>i_pixel_bot(19));
   ix3002 : xnor2 port map ( Y=>nx3001, A0=>i_pixel_mid(19), A1=>
      i_pixel_bot(20));
   ix3004 : xnor2 port map ( Y=>nx3003, A0=>nx3005, A1=>nx2818);
   ix3006 : xnor2 port map ( Y=>nx3005, A0=>nx2686, A1=>nx2634);
   ix2687 : mux21 port map ( Y=>nx2686, A0=>i_pixel_top(19), A1=>nx2989, S0
      =>nx2642);
   ix2635 : xnor2 port map ( Y=>nx2634, A0=>i_pixel_bot(4), A1=>
      i_pixel_top(20));
   ix3012 : xnor2 port map ( Y=>nx3011, A0=>nx3013, A1=>nx3015);
   ix3014 : mux21 port map ( Y=>nx3013, A0=>nx2748, A1=>i_pixel_bot(20), S0
      =>nx3001);
   ix3016 : xnor2 port map ( Y=>nx3015, A0=>i_pixel_mid(20), A1=>
      i_pixel_bot(21));
   ix3018 : xnor2 port map ( Y=>nx3017, A0=>nx2808, A1=>nx3011);
   ix2809 : xnor2 port map ( Y=>nx2808, A0=>nx3021, A1=>nx2626);
   ix3022 : aoi22 port map ( Y=>nx3021, A0=>nx3023, A1=>i_pixel_bot(4), B0=>
      nx2686, B1=>nx2634);
   ix3024 : inv01 port map ( Y=>nx3023, A=>i_pixel_top(20));
   ix2627 : xnor2 port map ( Y=>nx2626, A0=>i_pixel_bot(5), A1=>
      i_pixel_top(21));
   ix2795 : xnor2 port map ( Y=>nx2794, A0=>nx2756, A1=>nx3033);
   ix2757 : mux21 port map ( Y=>nx2756, A0=>nx3013, A1=>nx3031, S0=>nx3015);
   ix3032 : inv01 port map ( Y=>nx3031, A=>i_pixel_bot(21));
   ix3034 : xnor2 port map ( Y=>nx3033, A0=>i_pixel_mid(21), A1=>
      i_pixel_bot(22));
   ix3036 : xnor2 port map ( Y=>nx3035, A0=>nx3037, A1=>nx2794);
   ix3038 : xnor2 port map ( Y=>nx3037, A0=>nx2694, A1=>nx2618);
   ix2695 : mux21 port map ( Y=>nx2694, A0=>i_pixel_top(21), A1=>nx3021, S0
      =>nx2626);
   ix2619 : xnor2 port map ( Y=>nx2618, A0=>i_pixel_bot(6), A1=>
      i_pixel_top(22));
   ix3044 : xnor2 port map ( Y=>nx3043, A0=>nx2784, A1=>nx3053);
   ix2785 : xnor2 port map ( Y=>nx2784, A0=>nx3047, A1=>nx2610);
   ix3048 : aoi22 port map ( Y=>nx3047, A0=>nx3049, A1=>i_pixel_bot(6), B0=>
      nx2694, B1=>nx2618);
   ix3050 : inv01 port map ( Y=>nx3049, A=>i_pixel_top(22));
   ix2611 : xnor2 port map ( Y=>nx2610, A0=>i_pixel_bot(7), A1=>
      i_pixel_top(23));
   ix3054 : xnor2 port map ( Y=>nx3053, A0=>nx3055, A1=>nx3057);
   ix3056 : mux21 port map ( Y=>nx3055, A0=>nx2756, A1=>i_pixel_bot(22), S0
      =>nx3033);
   ix3058 : xnor2 port map ( Y=>nx3057, A0=>i_pixel_mid(22), A1=>
      i_pixel_bot(23));
   ix3111 : mux21 port map ( Y=>nx3110, A0=>nx3061, A1=>nx3063, S0=>nx3022);
   ix3062 : xnor2 port map ( Y=>nx3061, A0=>nx2929, A1=>nx3035);
   ix3064 : mux21 port map ( Y=>nx3063, A0=>nx3028, A1=>nx3102, S0=>nx3032);
   ix3029 : xnor2 port map ( Y=>nx3028, A0=>nx2902, A1=>nx3017);
   ix3103 : mux21 port map ( Y=>nx3102, A0=>nx3069, A1=>nx3071, S0=>nx3042);
   ix3070 : xnor2 port map ( Y=>nx3069, A0=>nx2933, A1=>nx3003);
   ix3072 : mux21 port map ( Y=>nx3071, A0=>nx3048, A1=>nx3094, S0=>nx3052);
   ix3049 : xnor2 port map ( Y=>nx3048, A0=>nx2894, A1=>nx2985);
   ix3080 : mux21 port map ( Y=>nx3079, A0=>nx3068, A1=>nx3086, S0=>nx3076);
   ix3069 : xnor2 port map ( Y=>nx3068, A0=>nx2886, A1=>nx2957);
   ix3094 : inv01 port map ( Y=>nx3093, A=>i_pixel_bot(16));
   ix3077 : xnor2 port map ( Y=>nx3076, A0=>nx3099, A1=>nx3068);
   ix3100 : oai21 port map ( Y=>nx3099, A0=>i_pixel_top(1), A1=>
      i_pixel_mid(0), B0=>nx3101);
   ix3102 : nand02 port map ( Y=>nx3101, A0=>i_pixel_mid(0), A1=>
      i_pixel_top(1));
   ix3063 : xnor2 port map ( Y=>nx3062, A0=>nx3105, A1=>nx3058);
   ix3106 : xnor2 port map ( Y=>nx3105, A0=>nx3101, A1=>nx3107);
   ix3108 : xnor2 port map ( Y=>nx3107, A0=>i_pixel_mid(1), A1=>
      i_pixel_top(2));
   ix3059 : xnor2 port map ( Y=>nx3058, A0=>nx2943, A1=>nx2846);
   ix3053 : xnor2 port map ( Y=>nx3052, A0=>nx3113, A1=>nx3048);
   ix3114 : xnor2 port map ( Y=>nx3113, A0=>nx3115, A1=>nx3121);
   ix3116 : aoi32 port map ( Y=>nx3115, A0=>i_pixel_mid(0), A1=>
      i_pixel_top(1), A2=>nx2954, B0=>i_pixel_top(2), B1=>i_pixel_mid(1));
   ix3122 : xnor2 port map ( Y=>nx3121, A0=>i_pixel_mid(2), A1=>
      i_pixel_top(3));
   ix3043 : xnor2 port map ( Y=>nx3042, A0=>nx3040, A1=>nx3069);
   ix3041 : xnor2 port map ( Y=>nx3040, A0=>nx2968, A1=>nx3129);
   ix2969 : mux21 port map ( Y=>nx2968, A0=>nx3115, A1=>nx3127, S0=>nx3121);
   ix3128 : inv01 port map ( Y=>nx3127, A=>i_pixel_top(3));
   ix3130 : xnor2 port map ( Y=>nx3129, A0=>i_pixel_mid(3), A1=>
      i_pixel_top(4));
   ix3033 : xnor2 port map ( Y=>nx3032, A0=>nx3133, A1=>nx3028);
   ix3134 : xnor2 port map ( Y=>nx3133, A0=>nx3135, A1=>nx3137);
   ix3136 : mux21 port map ( Y=>nx3135, A0=>nx2968, A1=>i_pixel_top(4), S0=>
      nx3129);
   ix3138 : xnor2 port map ( Y=>nx3137, A0=>i_pixel_mid(4), A1=>
      i_pixel_top(5));
   ix3023 : xnor2 port map ( Y=>nx3022, A0=>nx3020, A1=>nx3061);
   ix3021 : xnor2 port map ( Y=>nx3020, A0=>nx2976, A1=>nx3145);
   ix2977 : mux21 port map ( Y=>nx2976, A0=>nx3135, A1=>nx3143, S0=>nx3137);
   ix3144 : inv01 port map ( Y=>nx3143, A=>i_pixel_top(5));
   ix3146 : xnor2 port map ( Y=>nx3145, A0=>i_pixel_mid(5), A1=>
      i_pixel_top(6));
   ix3013 : xnor2 port map ( Y=>nx3012, A0=>nx3149, A1=>nx3008);
   ix3150 : xnor2 port map ( Y=>nx3149, A0=>nx3151, A1=>nx3153);
   ix3152 : mux21 port map ( Y=>nx3151, A0=>nx2976, A1=>i_pixel_top(6), S0=>
      nx3145);
   ix3154 : xnor2 port map ( Y=>nx3153, A0=>i_pixel_mid(6), A1=>
      i_pixel_top(7));
   ix3003 : xnor2 port map ( Y=>nx3002, A0=>nx3157, A1=>nx2994);
   ix3158 : xnor2 port map ( Y=>nx3157, A0=>i_pixel_mid(7), A1=>nx2984);
   ix2985 : mux21 port map ( Y=>nx2984, A0=>nx3151, A1=>nx3161, S0=>nx3153);
   ix3162 : inv01 port map ( Y=>nx3161, A=>i_pixel_top(7));
   ix2995 : xnor2 port map ( Y=>nx2994, A0=>nx3165, A1=>nx2774);
   ix3166 : mux21 port map ( Y=>nx3165, A0=>nx2910, A1=>nx3053, S0=>nx3043);
   ix2775 : xnor2 port map ( Y=>nx2774, A0=>nx2702, A1=>nx3171);
   ix2703 : mux21 port map ( Y=>nx2702, A0=>i_pixel_top(23), A1=>nx3047, S0
      =>nx2610);
   ix3172 : xnor2 port map ( Y=>nx3171, A0=>i_pixel_mid(23), A1=>nx2764);
   ix2765 : mux21 port map ( Y=>nx2764, A0=>nx3055, A1=>nx3175, S0=>nx3057);
   ix3176 : inv01 port map ( Y=>nx3175, A=>i_pixel_bot(23));
   derivative_reg_D_E_W_8 : dffr port map ( Q=>w_D_E_W_8, QB=>nx3177, D=>
      nx2747, CLK=>i_clock, R=>i_reset);
   ix3184 : aoi21 port map ( Y=>nx3183, A0=>nx5286, A1=>w_D_E_W_10, B0=>
      nx3166);
   ix3167 : nor03 port map ( Y=>nx3166, A0=>nx3187, A1=>nx5286, A2=>nx3146);
   ix3188 : nor02ii port map ( Y=>nx3187, A0=>nx3144, A1=>nx3201);
   ix3145 : nand02 port map ( Y=>nx3144, A0=>nx2702, A1=>nx3136);
   ix3137 : nand02 port map ( Y=>nx3136, A0=>nx3192, A1=>nx2702);
   ix3193 : mux21 port map ( Y=>nx3192, A0=>nx3195, A1=>nx2918, S0=>nx2920);
   ix2919 : mux21 port map ( Y=>nx2918, A0=>nx2702, A1=>nx3165, S0=>nx2774);
   ix2921 : xnor2 port map ( Y=>nx2920, A0=>nx2702, A1=>nx3199);
   ix3200 : nand02 port map ( Y=>nx3199, A0=>i_pixel_mid(23), A1=>nx2764);
   ix3202 : mux21 port map ( Y=>nx3201, A0=>nx3118, A1=>nx2922, S0=>nx3208);
   ix3119 : mux21 port map ( Y=>nx3118, A0=>nx3205, A1=>nx2923, S0=>nx3002);
   ix3209 : xnor2 port map ( Y=>nx3208, A0=>nx3211, A1=>nx3213);
   ix3212 : nand02 port map ( Y=>nx3211, A0=>i_pixel_mid(7), A1=>nx2984);
   ix3214 : xnor2 port map ( Y=>nx3213, A0=>nx2918, A1=>nx2920);
   ix3147 : nor02ii port map ( Y=>nx3146, A0=>nx3201, A1=>nx3144);
   derivative_reg_D_E_W_10 : dffr port map ( Q=>w_D_E_W_10, QB=>nx3217, D=>
      nx2727, CLK=>i_clock, R=>i_reset);
   ix3224 : mux21 port map ( Y=>nx3223, A0=>w_D_E_W_9, A1=>nx3184, S0=>
      i_valid);
   ix3185 : xnor2 port map ( Y=>nx3184, A0=>nx3118, A1=>nx3208);
   derivative_reg_D_E_W_9 : dffr port map ( Q=>w_D_E_W_9, QB=>nx3227, D=>
      nx2737, CLK=>i_clock, R=>i_reset);
   ix3236 : mux21 port map ( Y=>nx3235, A0=>w_D_E_W_5, A1=>nx3248, S0=>
      i_valid);
   ix3249 : xor2 port map ( Y=>nx3248, A0=>nx3102, A1=>nx3032);
   derivative_reg_D_E_W_5 : dffr port map ( Q=>w_D_E_W_5, QB=>nx3239, D=>
      nx2777, CLK=>i_clock, R=>i_reset);
   ix3244 : mux21 port map ( Y=>nx3243, A0=>w_D_E_W_7, A1=>nx3216, S0=>
      i_valid);
   ix3217 : xor2 port map ( Y=>nx3216, A0=>nx3110, A1=>nx3012);
   derivative_reg_D_E_W_7 : dffr port map ( Q=>w_D_E_W_7, QB=>nx3247, D=>
      nx2757, CLK=>i_clock, R=>i_reset);
   ix3254 : mux21 port map ( Y=>nx3253, A0=>w_D_E_W_6, A1=>nx3232, S0=>
      i_valid);
   ix3233 : xnor2 port map ( Y=>nx3232, A0=>nx3063, A1=>nx3022);
   derivative_reg_D_E_W_6 : dffr port map ( Q=>w_D_E_W_6, QB=>nx3256, D=>
      nx2767, CLK=>i_clock, R=>i_reset);
   ix3264 : mux21 port map ( Y=>nx3263, A0=>w_D_E_W_2, A1=>nx3296, S0=>
      i_valid);
   ix3297 : xnor2 port map ( Y=>nx3296, A0=>nx3079, A1=>nx3062);
   derivative_reg_D_E_W_2 : dffr port map ( Q=>w_D_E_W_2, QB=>nx3267, D=>
      nx2807, CLK=>i_clock, R=>i_reset);
   ix3273 : mux21 port map ( Y=>nx3272, A0=>w_D_E_W_4, A1=>nx3264, S0=>
      i_valid);
   ix3265 : xnor2 port map ( Y=>nx3264, A0=>nx3071, A1=>nx3042);
   derivative_reg_D_E_W_4 : dffr port map ( Q=>w_D_E_W_4, QB=>nx3275, D=>
      nx2787, CLK=>i_clock, R=>i_reset);
   ix3280 : mux21 port map ( Y=>nx3279, A0=>w_D_E_W_3, A1=>nx3280, S0=>
      i_valid);
   ix3281 : xnor2 port map ( Y=>nx3280, A0=>nx3283, A1=>nx3052);
   ix3284 : mux21 port map ( Y=>nx3283, A0=>nx3058, A1=>nx3090, S0=>nx3062);
   ix3290 : oai21 port map ( Y=>nx3289, A0=>nx3291, A1=>nx2876, B0=>
      i_pixel_top(0));
   ix2877 : aoi21 port map ( Y=>nx2876, A0=>nx2672, A1=>nx2947, B0=>
      i_pixel_bot(16));
   derivative_reg_D_E_W_3 : dffr port map ( Q=>w_D_E_W_3, QB=>nx3295, D=>
      nx2797, CLK=>i_clock, R=>i_reset);
   ix3302 : mux21 port map ( Y=>nx3301, A0=>w_D_E_W_1, A1=>nx3312, S0=>
      i_valid);
   derivative_reg_D_E_W_1 : dffr port map ( Q=>w_D_E_W_1, QB=>nx3297, D=>
      nx2817, CLK=>i_clock, R=>i_reset);
   ix3313 : xnor2 port map ( Y=>nx3312, A0=>nx3289, A1=>nx3076);
   ix3341 : oai22 port map ( Y=>nx3340, A0=>nx3311, A1=>nx3313, B0=>i_valid, 
      B1=>nx3305);
   ix3312 : nor03 port map ( Y=>nx3311, A0=>nx2876, A1=>i_pixel_top(0), A2=>
      nx3291);
   ix3314 : nand02 port map ( Y=>nx3313, A0=>i_valid, A1=>nx3289);
   derivative_reg_D_E_W_0 : dffr port map ( Q=>w_D_E_W_0, QB=>nx3305, D=>
      nx2827, CLK=>i_clock, R=>i_reset);
   ix3321 : mux21 port map ( Y=>nx3320, A0=>nx5256, A1=>nx3150, S0=>i_valid
   );
   derivative_reg_D_E_W_11 : dffr port map ( Q=>OPEN, QB=>nx3317, D=>nx2717, 
      CLK=>i_clock, R=>i_reset);
   ix3151 : xnor2 port map ( Y=>nx3150, A0=>nx3146, A1=>nx3325);
   ix3326 : xnor2 port map ( Y=>nx3325, A0=>nx3136, A1=>nx2702);
   ix4501 : nand02 port map ( Y=>nx4500, A0=>nx3329, A1=>nx5341);
   ix3330 : nand04 port map ( Y=>nx3329, A0=>nx4478, A1=>nx4488, A2=>nx3715, 
      A3=>nx3725);
   ix3338 : mux21 port map ( Y=>nx3337, A0=>w_D_NE_SW_8, A1=>nx1500, S0=>
      i_valid);
   ix1501 : xnor2 port map ( Y=>nx1500, A0=>nx3341, A1=>nx1176);
   ix3342 : mux21 port map ( Y=>nx3341, A0=>nx1182, A1=>nx1284, S0=>nx1186);
   ix1183 : xnor2 port map ( Y=>nx1182, A0=>nx1084, A1=>nx3453);
   ix1085 : mux21 port map ( Y=>nx1084, A0=>nx3345, A1=>nx968, S0=>nx3445);
   ix3346 : mux21 port map ( Y=>nx3345, A0=>nx1076, A1=>nx3421, S0=>nx3427);
   ix1077 : mux21 port map ( Y=>nx1076, A0=>nx3349, A1=>nx992, S0=>nx3415);
   ix3350 : mux21 port map ( Y=>nx3349, A0=>nx1068, A1=>nx3391, S0=>nx3401);
   ix1069 : mux21 port map ( Y=>nx1068, A0=>nx1016, A1=>nx3359, S0=>nx1020);
   ix3356 : nand02 port map ( Y=>nx3355, A0=>i_pixel_bot(9), A1=>
      i_pixel_bot(16));
   ix3358 : xnor2 port map ( Y=>nx3357, A0=>i_pixel_bot(10), A1=>
      i_pixel_bot(17));
   ix3360 : mux21 port map ( Y=>nx3359, A0=>nx1060, A1=>nx3371, S0=>nx3373);
   ix1061 : nand03 port map ( Y=>nx1060, A0=>nx3363, A1=>i_pixel_bot(8), A2
      =>nx846);
   ix3364 : nand02 port map ( Y=>nx3363, A0=>nx3365, A1=>i_pixel_mid(0));
   ix3366 : inv01 port map ( Y=>nx3365, A=>i_pixel_mid(16));
   ix3372 : oai21 port map ( Y=>nx3371, A0=>i_pixel_bot(16), A1=>
      i_pixel_bot(9), B0=>nx3355);
   ix3374 : xnor2 port map ( Y=>nx3373, A0=>nx1034, A1=>nx3371);
   ix1035 : xnor2 port map ( Y=>nx1034, A0=>nx3377, A1=>nx832);
   ix833 : xnor2 port map ( Y=>nx832, A0=>i_pixel_mid(17), A1=>
      i_pixel_mid(1));
   ix1021 : xnor2 port map ( Y=>nx1020, A0=>nx3383, A1=>nx3389);
   ix3384 : xnor2 port map ( Y=>nx3383, A0=>nx852, A1=>nx824);
   ix853 : mux21 port map ( Y=>nx852, A0=>i_pixel_mid(17), A1=>nx3377, S0=>
      nx832);
   ix825 : xnor2 port map ( Y=>nx824, A0=>i_pixel_mid(18), A1=>
      i_pixel_mid(2));
   ix3390 : xnor2 port map ( Y=>nx3389, A0=>nx3355, A1=>nx3357);
   ix3392 : xnor2 port map ( Y=>nx3391, A0=>nx3393, A1=>nx3399);
   ix3394 : aoi32 port map ( Y=>nx3393, A0=>i_pixel_bot(9), A1=>
      i_pixel_bot(16), A2=>nx908, B0=>i_pixel_bot(17), B1=>i_pixel_bot(10));
   ix3400 : xnor2 port map ( Y=>nx3399, A0=>i_pixel_bot(11), A1=>
      i_pixel_bot(18));
   ix3402 : xnor2 port map ( Y=>nx3401, A0=>nx1006, A1=>nx3391);
   ix1007 : xnor2 port map ( Y=>nx1006, A0=>nx3405, A1=>nx816);
   ix3406 : aoi22 port map ( Y=>nx3405, A0=>nx3407, A1=>i_pixel_mid(2), B0=>
      nx852, B1=>nx824);
   ix3408 : inv01 port map ( Y=>nx3407, A=>i_pixel_mid(18));
   ix817 : xnor2 port map ( Y=>nx816, A0=>i_pixel_mid(19), A1=>
      i_pixel_mid(3));
   ix993 : xnor2 port map ( Y=>nx992, A0=>nx922, A1=>nx3413);
   ix923 : mux21 port map ( Y=>nx922, A0=>nx3393, A1=>nx2981, S0=>nx3399);
   ix3414 : xnor2 port map ( Y=>nx3413, A0=>i_pixel_bot(12), A1=>
      i_pixel_bot(19));
   ix3416 : xnor2 port map ( Y=>nx3415, A0=>nx3417, A1=>nx992);
   ix3418 : xnor2 port map ( Y=>nx3417, A0=>nx860, A1=>nx808);
   ix861 : mux21 port map ( Y=>nx860, A0=>i_pixel_mid(19), A1=>nx3405, S0=>
      nx816);
   ix809 : xnor2 port map ( Y=>nx808, A0=>i_pixel_mid(20), A1=>
      i_pixel_mid(4));
   ix3422 : xnor2 port map ( Y=>nx3421, A0=>nx3423, A1=>nx3425);
   ix3424 : mux21 port map ( Y=>nx3423, A0=>nx922, A1=>i_pixel_bot(19), S0=>
      nx3413);
   ix3426 : xnor2 port map ( Y=>nx3425, A0=>i_pixel_bot(13), A1=>
      i_pixel_bot(20));
   ix3428 : xnor2 port map ( Y=>nx3427, A0=>nx982, A1=>nx3421);
   ix983 : xnor2 port map ( Y=>nx982, A0=>nx3431, A1=>nx800);
   ix3432 : aoi22 port map ( Y=>nx3431, A0=>nx3433, A1=>i_pixel_mid(4), B0=>
      nx860, B1=>nx808);
   ix3434 : inv01 port map ( Y=>nx3433, A=>i_pixel_mid(20));
   ix801 : xnor2 port map ( Y=>nx800, A0=>i_pixel_mid(21), A1=>
      i_pixel_mid(5));
   ix969 : xnor2 port map ( Y=>nx968, A0=>nx930, A1=>nx3443);
   ix931 : mux21 port map ( Y=>nx930, A0=>nx3423, A1=>nx3441, S0=>nx3425);
   ix3442 : inv01 port map ( Y=>nx3441, A=>i_pixel_bot(20));
   ix3444 : xnor2 port map ( Y=>nx3443, A0=>i_pixel_bot(14), A1=>
      i_pixel_bot(21));
   ix3446 : xnor2 port map ( Y=>nx3445, A0=>nx3447, A1=>nx968);
   ix3448 : xnor2 port map ( Y=>nx3447, A0=>nx868, A1=>nx792);
   ix869 : mux21 port map ( Y=>nx868, A0=>i_pixel_mid(21), A1=>nx3431, S0=>
      nx800);
   ix793 : xnor2 port map ( Y=>nx792, A0=>i_pixel_mid(22), A1=>
      i_pixel_mid(6));
   ix3454 : xnor2 port map ( Y=>nx3453, A0=>nx958, A1=>nx3463);
   ix959 : xnor2 port map ( Y=>nx958, A0=>nx3457, A1=>nx784);
   ix3458 : aoi22 port map ( Y=>nx3457, A0=>nx3459, A1=>i_pixel_mid(6), B0=>
      nx868, B1=>nx792);
   ix3460 : inv01 port map ( Y=>nx3459, A=>i_pixel_mid(22));
   ix785 : xnor2 port map ( Y=>nx784, A0=>i_pixel_mid(23), A1=>
      i_pixel_mid(7));
   ix3464 : xnor2 port map ( Y=>nx3463, A0=>nx3465, A1=>nx3467);
   ix3466 : mux21 port map ( Y=>nx3465, A0=>nx930, A1=>i_pixel_bot(21), S0=>
      nx3443);
   ix3468 : xnor2 port map ( Y=>nx3467, A0=>i_pixel_bot(15), A1=>
      i_pixel_bot(22));
   ix1285 : mux21 port map ( Y=>nx1284, A0=>nx3471, A1=>nx3473, S0=>nx1196);
   ix3472 : xnor2 port map ( Y=>nx3471, A0=>nx3345, A1=>nx3445);
   ix3474 : mux21 port map ( Y=>nx3473, A0=>nx1202, A1=>nx1276, S0=>nx1206);
   ix1203 : xnor2 port map ( Y=>nx1202, A0=>nx1076, A1=>nx3427);
   ix1277 : mux21 port map ( Y=>nx1276, A0=>nx3479, A1=>nx3481, S0=>nx1216);
   ix3480 : xnor2 port map ( Y=>nx3479, A0=>nx3349, A1=>nx3415);
   ix3482 : mux21 port map ( Y=>nx3481, A0=>nx1222, A1=>nx1268, S0=>nx1226);
   ix1223 : xnor2 port map ( Y=>nx1222, A0=>nx1068, A1=>nx3401);
   ix3490 : mux21 port map ( Y=>nx3489, A0=>nx1242, A1=>nx1260, S0=>nx1250);
   ix1243 : xnor2 port map ( Y=>nx1242, A0=>nx1060, A1=>nx3373);
   ix3502 : inv01 port map ( Y=>nx3501, A=>i_pixel_bot(8));
   ix1251 : xnor2 port map ( Y=>nx1250, A0=>nx3507, A1=>nx1242);
   ix3508 : oai21 port map ( Y=>nx3507, A0=>i_pixel_top(9), A1=>
      i_pixel_top(0), B0=>nx3509);
   ix3510 : nand02 port map ( Y=>nx3509, A0=>i_pixel_top(0), A1=>
      i_pixel_top(9));
   ix1237 : xnor2 port map ( Y=>nx1236, A0=>nx3513, A1=>nx1232);
   ix3514 : xnor2 port map ( Y=>nx3513, A0=>nx3509, A1=>nx3515);
   ix3516 : xnor2 port map ( Y=>nx3515, A0=>i_pixel_top(1), A1=>
      i_pixel_top(10));
   ix1233 : xnor2 port map ( Y=>nx1232, A0=>nx3359, A1=>nx1020);
   ix1227 : xnor2 port map ( Y=>nx1226, A0=>nx3521, A1=>nx1222);
   ix3522 : xnor2 port map ( Y=>nx3521, A0=>nx3523, A1=>nx3529);
   ix3524 : aoi32 port map ( Y=>nx3523, A0=>i_pixel_top(0), A1=>
      i_pixel_top(9), A2=>nx1128, B0=>i_pixel_top(10), B1=>i_pixel_top(1));
   ix3528 : inv01 port map ( Y=>nx3527, A=>i_pixel_top(10));
   ix3530 : xnor2 port map ( Y=>nx3529, A0=>i_pixel_top(2), A1=>
      i_pixel_top(11));
   ix1217 : xnor2 port map ( Y=>nx1216, A0=>nx1214, A1=>nx3479);
   ix1215 : xnor2 port map ( Y=>nx1214, A0=>nx1142, A1=>nx3537);
   ix1143 : mux21 port map ( Y=>nx1142, A0=>nx3523, A1=>nx3535, S0=>nx3529);
   ix3536 : inv01 port map ( Y=>nx3535, A=>i_pixel_top(11));
   ix3538 : xnor2 port map ( Y=>nx3537, A0=>i_pixel_top(3), A1=>
      i_pixel_top(12));
   ix1207 : xnor2 port map ( Y=>nx1206, A0=>nx3541, A1=>nx1202);
   ix3542 : xnor2 port map ( Y=>nx3541, A0=>nx3543, A1=>nx3545);
   ix3544 : mux21 port map ( Y=>nx3543, A0=>nx1142, A1=>i_pixel_top(12), S0
      =>nx3537);
   ix3546 : xnor2 port map ( Y=>nx3545, A0=>i_pixel_top(4), A1=>
      i_pixel_top(13));
   ix1197 : xnor2 port map ( Y=>nx1196, A0=>nx1194, A1=>nx3471);
   ix1195 : xnor2 port map ( Y=>nx1194, A0=>nx1150, A1=>nx3555);
   ix1151 : mux21 port map ( Y=>nx1150, A0=>nx3543, A1=>nx3553, S0=>nx3545);
   ix3554 : inv01 port map ( Y=>nx3553, A=>i_pixel_top(13));
   ix3556 : xnor2 port map ( Y=>nx3555, A0=>i_pixel_top(5), A1=>
      i_pixel_top(14));
   ix1187 : xnor2 port map ( Y=>nx1186, A0=>nx3559, A1=>nx1182);
   ix3560 : xnor2 port map ( Y=>nx3559, A0=>nx3561, A1=>nx3563);
   ix3562 : mux21 port map ( Y=>nx3561, A0=>nx1150, A1=>i_pixel_top(14), S0
      =>nx3555);
   ix3564 : xnor2 port map ( Y=>nx3563, A0=>i_pixel_top(6), A1=>
      i_pixel_top(15));
   ix1177 : xnor2 port map ( Y=>nx1176, A0=>nx3567, A1=>nx1168);
   ix3568 : xnor2 port map ( Y=>nx3567, A0=>i_pixel_top(7), A1=>nx1158);
   ix1159 : mux21 port map ( Y=>nx1158, A0=>nx3561, A1=>nx3571, S0=>nx3563);
   ix3572 : inv01 port map ( Y=>nx3571, A=>i_pixel_top(15));
   ix1169 : xnor2 port map ( Y=>nx1168, A0=>nx3575, A1=>nx948);
   ix3576 : mux21 port map ( Y=>nx3575, A0=>nx1084, A1=>nx3463, S0=>nx3453);
   ix949 : xnor2 port map ( Y=>nx948, A0=>nx876, A1=>nx3581);
   ix877 : mux21 port map ( Y=>nx876, A0=>i_pixel_mid(23), A1=>nx3457, S0=>
      nx784);
   ix3582 : xnor2 port map ( Y=>nx3581, A0=>i_pixel_bot(23), A1=>nx938);
   ix939 : mux21 port map ( Y=>nx938, A0=>nx3465, A1=>nx3585, S0=>nx3467);
   ix3586 : inv01 port map ( Y=>nx3585, A=>i_pixel_bot(22));
   derivative_reg_D_NE_SW_8 : dffr port map ( Q=>w_D_NE_SW_8, QB=>nx3587, D
      =>nx2547, CLK=>i_clock, R=>i_reset);
   ix3594 : aoi21 port map ( Y=>nx3593, A0=>nx5286, A1=>w_D_NE_SW_10, B0=>
      nx1578);
   ix1579 : nor03 port map ( Y=>nx1578, A0=>nx3597, A1=>nx5286, A2=>nx1320);
   ix3598 : nor02ii port map ( Y=>nx3597, A0=>nx1318, A1=>nx3611);
   ix1319 : nand02 port map ( Y=>nx1318, A0=>nx876, A1=>nx1310);
   ix1311 : nand02 port map ( Y=>nx1310, A0=>nx3601, A1=>nx876);
   ix3602 : mux21 port map ( Y=>nx3601, A0=>nx3603, A1=>nx1092, S0=>nx1094);
   ix1093 : mux21 port map ( Y=>nx1092, A0=>nx876, A1=>nx3575, S0=>nx948);
   ix1095 : xnor2 port map ( Y=>nx1094, A0=>nx876, A1=>nx3609);
   ix3610 : nand02 port map ( Y=>nx3609, A0=>i_pixel_bot(23), A1=>nx938);
   ix3612 : mux21 port map ( Y=>nx3611, A0=>nx1292, A1=>nx1096, S0=>nx3619);
   ix1293 : mux21 port map ( Y=>nx1292, A0=>nx3615, A1=>nx3341, S0=>nx1176);
   ix3620 : xnor2 port map ( Y=>nx3619, A0=>nx3621, A1=>nx3623);
   ix3622 : nand02 port map ( Y=>nx3621, A0=>i_pixel_top(7), A1=>nx1158);
   ix3624 : xnor2 port map ( Y=>nx3623, A0=>nx1092, A1=>nx1094);
   ix1321 : nor02ii port map ( Y=>nx1320, A0=>nx3611, A1=>nx1318);
   derivative_reg_D_NE_SW_10 : dffr port map ( Q=>w_D_NE_SW_10, QB=>nx3627, 
      D=>nx2577, CLK=>i_clock, R=>i_reset);
   ix3634 : mux21 port map ( Y=>nx3633, A0=>w_D_NE_SW_9, A1=>nx1596, S0=>
      i_valid);
   ix1597 : xnor2 port map ( Y=>nx1596, A0=>nx1292, A1=>nx3619);
   derivative_reg_D_NE_SW_9 : dffr port map ( Q=>w_D_NE_SW_9, QB=>nx3637, D
      =>nx2587, CLK=>i_clock, R=>i_reset);
   ix3646 : mux21 port map ( Y=>nx3645, A0=>w_D_NE_SW_5, A1=>nx1440, S0=>
      i_valid);
   ix1441 : xor2 port map ( Y=>nx1440, A0=>nx1276, A1=>nx1206);
   derivative_reg_D_NE_SW_5 : dffr port map ( Q=>w_D_NE_SW_5, QB=>nx3649, D
      =>nx2527, CLK=>i_clock, R=>i_reset);
   ix3656 : mux21 port map ( Y=>nx3655, A0=>w_D_NE_SW_7, A1=>nx1516, S0=>
      i_valid);
   ix1517 : xor2 port map ( Y=>nx1516, A0=>nx1284, A1=>nx1186);
   derivative_reg_D_NE_SW_7 : dffr port map ( Q=>w_D_NE_SW_7, QB=>nx3659, D
      =>nx2557, CLK=>i_clock, R=>i_reset);
   ix3666 : mux21 port map ( Y=>nx3665, A0=>w_D_NE_SW_6, A1=>nx1532, S0=>
      i_valid);
   ix1533 : xnor2 port map ( Y=>nx1532, A0=>nx3473, A1=>nx1196);
   derivative_reg_D_NE_SW_6 : dffr port map ( Q=>w_D_NE_SW_6, QB=>nx3669, D
      =>nx2567, CLK=>i_clock, R=>i_reset);
   ix3678 : mux21 port map ( Y=>nx3677, A0=>w_D_NE_SW_2, A1=>nx1404, S0=>
      i_valid);
   ix1405 : xnor2 port map ( Y=>nx1404, A0=>nx3489, A1=>nx1236);
   derivative_reg_D_NE_SW_2 : dffr port map ( Q=>w_D_NE_SW_2, QB=>nx3681, D
      =>nx2517, CLK=>i_clock, R=>i_reset);
   ix3688 : mux21 port map ( Y=>nx3687, A0=>w_D_NE_SW_4, A1=>nx1456, S0=>
      i_valid);
   ix1457 : xnor2 port map ( Y=>nx1456, A0=>nx3481, A1=>nx1216);
   derivative_reg_D_NE_SW_4 : dffr port map ( Q=>w_D_NE_SW_4, QB=>nx3691, D
      =>nx2537, CLK=>i_clock, R=>i_reset);
   ix3698 : mux21 port map ( Y=>nx3697, A0=>w_D_NE_SW_3, A1=>nx1388, S0=>
      i_valid);
   ix1389 : xnor2 port map ( Y=>nx1388, A0=>nx3701, A1=>nx1226);
   ix3702 : mux21 port map ( Y=>nx3701, A0=>nx1232, A1=>nx1264, S0=>nx1236);
   ix3708 : oai21 port map ( Y=>nx3707, A0=>nx3709, A1=>nx1050, B0=>
      i_pixel_top(8));
   ix1051 : aoi21 port map ( Y=>nx1050, A0=>nx846, A1=>nx3363, B0=>
      i_pixel_bot(8));
   derivative_reg_D_NE_SW_3 : dffr port map ( Q=>w_D_NE_SW_3, QB=>nx3713, D
      =>nx2507, CLK=>i_clock, R=>i_reset);
   ix3720 : mux21 port map ( Y=>nx3719, A0=>w_D_NE_SW_1, A1=>nx1338, S0=>
      i_valid);
   derivative_reg_D_NE_SW_1 : dffr port map ( Q=>w_D_NE_SW_1, QB=>nx3715, D
      =>nx2487, CLK=>i_clock, R=>i_reset);
   ix1339 : xnor2 port map ( Y=>nx1338, A0=>nx3707, A1=>nx1250);
   ix1367 : oai22 port map ( Y=>nx1366, A0=>nx3729, A1=>nx3731, B0=>i_valid, 
      B1=>nx3725);
   ix3730 : nor03 port map ( Y=>nx3729, A0=>nx1050, A1=>i_pixel_top(8), A2=>
      nx3709);
   ix3732 : nand02 port map ( Y=>nx3731, A0=>i_valid, A1=>nx3707);
   derivative_reg_D_NE_SW_0 : dffr port map ( Q=>w_D_NE_SW_0, QB=>nx3725, D
      =>nx2497, CLK=>i_clock, R=>i_reset);
   ix3740 : mux21 port map ( Y=>nx3739, A0=>nx5244, A1=>nx1324, S0=>i_valid
   );
   derivative_reg_D_NE_SW_11 : dffr port map ( Q=>OPEN, QB=>nx3735, D=>
      nx2477, CLK=>i_clock, R=>i_reset);
   ix1325 : xnor2 port map ( Y=>nx1324, A0=>nx1320, A1=>nx3743);
   ix3744 : xnor2 port map ( Y=>nx3743, A0=>nx1310, A1=>nx876);
   ix3750 : mux21 port map ( Y=>nx3749, A0=>nx4006, A1=>nx778, S0=>nx3710);
   ix4007 : mux21 port map ( Y=>nx4006, A0=>nx3753, A1=>nx4996, S0=>nx3730);
   ix3754 : mux21 port map ( Y=>nx3753, A0=>nx3990, A1=>nx756, S0=>nx3744);
   ix3991 : mux21 port map ( Y=>nx3990, A0=>nx3757, A1=>nx4964, S0=>nx3764);
   ix3758 : mux21 port map ( Y=>nx3757, A0=>nx3974, A1=>nx3770, S0=>nx3784);
   ix3975 : mux21 port map ( Y=>nx3974, A0=>nx3761, A1=>nx4932, S0=>nx3804);
   ix3762 : mux21 port map ( Y=>nx3761, A0=>nx3958, A1=>nx3810, S0=>nx3824);
   ix3959 : mux21 port map ( Y=>nx3958, A0=>nx3765, A1=>nx4900, S0=>nx3844);
   ix3766 : mux21 port map ( Y=>nx3765, A0=>nx3942, A1=>nx3850, S0=>nx3864);
   ix3943 : mux21 port map ( Y=>nx3942, A0=>nx3769, A1=>nx4861, S0=>nx3884);
   ix3770 : mux21 port map ( Y=>nx3769, A0=>nx3926, A1=>nx3890, S0=>nx3904);
   ix3927 : aoi21 port map ( Y=>nx3926, A0=>nx3918, A1=>nx5294, B0=>nx4607);
   ix2367 : oai22 port map ( Y=>nx2366, A0=>nx3783, A1=>nx3797, B0=>i_valid, 
      B1=>nx3801);
   ix3784 : nor03 port map ( Y=>nx3783, A0=>nx1902, A1=>i_pixel_top(16), A2
      =>nx3791);
   ix1903 : aoi21 port map ( Y=>nx1902, A0=>nx1698, A1=>nx3789, B0=>
      i_pixel_bot(0));
   ix3790 : nand02 port map ( Y=>nx3789, A0=>nx3093, A1=>i_pixel_top(0));
   ix3798 : nand02 port map ( Y=>nx3797, A0=>i_valid, A1=>nx3799);
   ix3800 : oai21 port map ( Y=>nx3799, A0=>nx3791, A1=>nx1902, B0=>
      i_pixel_top(16));
   derivative_reg_D_N_S_0 : dffr port map ( Q=>w_D_N_S_0, QB=>nx3801, D=>
      nx2707, CLK=>i_clock, R=>i_reset);
   ix3804 : mux21 port map ( Y=>nx3803, A0=>nx2394, A1=>nx2590, S0=>nx4371);
   ix2395 : nor02ii port map ( Y=>nx2394, A0=>nx3807, A1=>nx2392);
   ix3814 : mux21 port map ( Y=>nx3813, A0=>nx5248, A1=>nx2176, S0=>i_valid
   );
   ix2177 : xnor2 port map ( Y=>nx2176, A0=>nx2172, A1=>nx4071);
   ix2173 : nor02ii port map ( Y=>nx2172, A0=>nx3819, A1=>nx2170);
   ix3820 : mux21 port map ( Y=>nx3819, A0=>nx2144, A1=>nx1948, S0=>nx4057);
   ix2145 : mux21 port map ( Y=>nx2144, A0=>nx3823, A1=>nx3947, S0=>nx2028);
   ix3826 : mux21 port map ( Y=>nx3825, A0=>nx1936, A1=>nx3923, S0=>nx3929);
   ix1937 : mux21 port map ( Y=>nx1936, A0=>nx3829, A1=>nx1820, S0=>nx3917);
   ix3830 : mux21 port map ( Y=>nx3829, A0=>nx1928, A1=>nx3895, S0=>nx3901);
   ix1929 : mux21 port map ( Y=>nx1928, A0=>nx3833, A1=>nx1844, S0=>nx3889);
   ix3834 : mux21 port map ( Y=>nx3833, A0=>nx1920, A1=>nx3865, S0=>nx3875);
   ix1921 : mux21 port map ( Y=>nx1920, A0=>nx1868, A1=>nx3843, S0=>nx1872);
   ix3840 : nand02 port map ( Y=>nx3839, A0=>i_pixel_bot(1), A1=>
      i_pixel_bot(8));
   ix3842 : xnor2 port map ( Y=>nx3841, A0=>i_pixel_bot(2), A1=>
      i_pixel_bot(9));
   ix3844 : mux21 port map ( Y=>nx3843, A0=>nx1912, A1=>nx3847, S0=>nx3849);
   ix1913 : nand03 port map ( Y=>nx1912, A0=>nx3789, A1=>i_pixel_bot(0), A2
      =>nx1698);
   ix3848 : oai21 port map ( Y=>nx3847, A0=>i_pixel_bot(8), A1=>
      i_pixel_bot(1), B0=>nx3839);
   ix3850 : xnor2 port map ( Y=>nx3849, A0=>nx1886, A1=>nx3847);
   ix1887 : xnor2 port map ( Y=>nx1886, A0=>nx3853, A1=>nx1684);
   ix1685 : xnor2 port map ( Y=>nx1684, A0=>i_pixel_bot(17), A1=>
      i_pixel_top(1));
   ix1873 : xnor2 port map ( Y=>nx1872, A0=>nx3859, A1=>nx3863);
   ix3860 : xnor2 port map ( Y=>nx3859, A0=>nx1704, A1=>nx1676);
   ix1705 : mux21 port map ( Y=>nx1704, A0=>i_pixel_bot(17), A1=>nx3853, S0
      =>nx1684);
   ix1677 : xnor2 port map ( Y=>nx1676, A0=>i_pixel_bot(18), A1=>
      i_pixel_top(2));
   ix3864 : xnor2 port map ( Y=>nx3863, A0=>nx3839, A1=>nx3841);
   ix3866 : xnor2 port map ( Y=>nx3865, A0=>nx3867, A1=>nx3873);
   ix3868 : aoi32 port map ( Y=>nx3867, A0=>i_pixel_bot(1), A1=>
      i_pixel_bot(8), A2=>nx1760, B0=>i_pixel_bot(9), B1=>i_pixel_bot(2));
   ix3874 : xnor2 port map ( Y=>nx3873, A0=>i_pixel_bot(3), A1=>
      i_pixel_bot(10));
   ix3876 : xnor2 port map ( Y=>nx3875, A0=>nx1858, A1=>nx3865);
   ix1859 : xnor2 port map ( Y=>nx1858, A0=>nx3879, A1=>nx1668);
   ix3880 : aoi22 port map ( Y=>nx3879, A0=>nx2981, A1=>i_pixel_top(2), B0=>
      nx1704, B1=>nx1676);
   ix1669 : xnor2 port map ( Y=>nx1668, A0=>i_pixel_bot(19), A1=>
      i_pixel_top(3));
   ix1845 : xnor2 port map ( Y=>nx1844, A0=>nx1774, A1=>nx3887);
   ix1775 : mux21 port map ( Y=>nx1774, A0=>nx3867, A1=>nx3885, S0=>nx3873);
   ix3886 : inv01 port map ( Y=>nx3885, A=>i_pixel_bot(10));
   ix3888 : xnor2 port map ( Y=>nx3887, A0=>i_pixel_bot(4), A1=>
      i_pixel_bot(11));
   ix3890 : xnor2 port map ( Y=>nx3889, A0=>nx3891, A1=>nx1844);
   ix3892 : xnor2 port map ( Y=>nx3891, A0=>nx1712, A1=>nx1660);
   ix1713 : mux21 port map ( Y=>nx1712, A0=>i_pixel_bot(19), A1=>nx3879, S0
      =>nx1668);
   ix1661 : xnor2 port map ( Y=>nx1660, A0=>i_pixel_bot(20), A1=>
      i_pixel_top(4));
   ix3896 : xnor2 port map ( Y=>nx3895, A0=>nx3897, A1=>nx3899);
   ix3898 : mux21 port map ( Y=>nx3897, A0=>nx1774, A1=>i_pixel_bot(11), S0
      =>nx3887);
   ix3900 : xnor2 port map ( Y=>nx3899, A0=>i_pixel_bot(5), A1=>
      i_pixel_bot(12));
   ix3902 : xnor2 port map ( Y=>nx3901, A0=>nx1834, A1=>nx3895);
   ix1835 : xnor2 port map ( Y=>nx1834, A0=>nx3905, A1=>nx1652);
   ix3906 : aoi22 port map ( Y=>nx3905, A0=>nx3441, A1=>i_pixel_top(4), B0=>
      nx1712, B1=>nx1660);
   ix1653 : xnor2 port map ( Y=>nx1652, A0=>i_pixel_bot(21), A1=>
      i_pixel_top(5));
   ix1821 : xnor2 port map ( Y=>nx1820, A0=>nx1782, A1=>nx3915);
   ix1783 : mux21 port map ( Y=>nx1782, A0=>nx3897, A1=>nx3913, S0=>nx3899);
   ix3914 : inv01 port map ( Y=>nx3913, A=>i_pixel_bot(12));
   ix3916 : xnor2 port map ( Y=>nx3915, A0=>i_pixel_bot(6), A1=>
      i_pixel_bot(13));
   ix3918 : xnor2 port map ( Y=>nx3917, A0=>nx3919, A1=>nx1820);
   ix3920 : xnor2 port map ( Y=>nx3919, A0=>nx1720, A1=>nx1644);
   ix1721 : mux21 port map ( Y=>nx1720, A0=>i_pixel_bot(21), A1=>nx3905, S0
      =>nx1652);
   ix1645 : xnor2 port map ( Y=>nx1644, A0=>i_pixel_bot(22), A1=>
      i_pixel_top(6));
   ix3924 : xnor2 port map ( Y=>nx3923, A0=>nx3925, A1=>nx3927);
   ix3926 : mux21 port map ( Y=>nx3925, A0=>nx1782, A1=>i_pixel_bot(13), S0
      =>nx3915);
   ix3928 : xnor2 port map ( Y=>nx3927, A0=>i_pixel_bot(7), A1=>
      i_pixel_bot(14));
   ix3930 : xnor2 port map ( Y=>nx3929, A0=>nx1810, A1=>nx3923);
   ix1811 : xnor2 port map ( Y=>nx1810, A0=>nx3933, A1=>nx1636);
   ix3934 : aoi22 port map ( Y=>nx3933, A0=>nx3585, A1=>i_pixel_top(6), B0=>
      nx1720, B1=>nx1644);
   ix1637 : xnor2 port map ( Y=>nx1636, A0=>i_pixel_bot(23), A1=>
      i_pixel_top(7));
   ix1801 : xnor2 port map ( Y=>nx1800, A0=>nx1728, A1=>nx3941);
   ix1729 : mux21 port map ( Y=>nx1728, A0=>i_pixel_bot(23), A1=>nx3933, S0
      =>nx1636);
   ix3942 : xnor2 port map ( Y=>nx3941, A0=>i_pixel_bot(15), A1=>nx1790);
   ix1791 : mux21 port map ( Y=>nx1790, A0=>nx3925, A1=>nx3945, S0=>nx3927);
   ix3946 : inv01 port map ( Y=>nx3945, A=>i_pixel_bot(14));
   ix3948 : mux21 port map ( Y=>nx3947, A0=>nx2034, A1=>nx2136, S0=>nx2038);
   ix2035 : xnor2 port map ( Y=>nx2034, A0=>nx1936, A1=>nx3929);
   ix2137 : mux21 port map ( Y=>nx2136, A0=>nx3953, A1=>nx3955, S0=>nx2048);
   ix3954 : xnor2 port map ( Y=>nx3953, A0=>nx3829, A1=>nx3917);
   ix3956 : mux21 port map ( Y=>nx3955, A0=>nx2054, A1=>nx2128, S0=>nx2058);
   ix2055 : xnor2 port map ( Y=>nx2054, A0=>nx1928, A1=>nx3901);
   ix2129 : mux21 port map ( Y=>nx2128, A0=>nx3961, A1=>nx3963, S0=>nx2068);
   ix3962 : xnor2 port map ( Y=>nx3961, A0=>nx3833, A1=>nx3889);
   ix3964 : mux21 port map ( Y=>nx3963, A0=>nx2074, A1=>nx2120, S0=>nx2078);
   ix2075 : xnor2 port map ( Y=>nx2074, A0=>nx1920, A1=>nx3875);
   ix3972 : mux21 port map ( Y=>nx3971, A0=>nx2094, A1=>nx2112, S0=>nx2102);
   ix2095 : xnor2 port map ( Y=>nx2094, A0=>nx1912, A1=>nx3849);
   ix1911 : nand03 port map ( Y=>nx1910, A0=>nx3789, A1=>i_pixel_bot(0), A2
      =>nx1698);
   ix2103 : xnor2 port map ( Y=>nx2102, A0=>nx3983, A1=>nx2094);
   ix3984 : oai21 port map ( Y=>nx3983, A0=>i_pixel_top(8), A1=>
      i_pixel_top(17), B0=>nx3985);
   ix3986 : nand02 port map ( Y=>nx3985, A0=>i_pixel_top(17), A1=>
      i_pixel_top(8));
   ix2089 : xnor2 port map ( Y=>nx2088, A0=>nx3989, A1=>nx2084);
   ix3990 : xnor2 port map ( Y=>nx3989, A0=>nx3985, A1=>nx3991);
   ix3992 : xnor2 port map ( Y=>nx3991, A0=>i_pixel_top(18), A1=>
      i_pixel_top(9));
   ix2085 : xnor2 port map ( Y=>nx2084, A0=>nx3843, A1=>nx1872);
   ix2079 : xnor2 port map ( Y=>nx2078, A0=>nx3997, A1=>nx2074);
   ix3998 : xnor2 port map ( Y=>nx3997, A0=>nx3999, A1=>nx4005);
   ix4000 : aoi32 port map ( Y=>nx3999, A0=>i_pixel_top(17), A1=>
      i_pixel_top(8), A2=>nx1980, B0=>i_pixel_top(9), B1=>i_pixel_top(18));
   ix4006 : xnor2 port map ( Y=>nx4005, A0=>i_pixel_top(19), A1=>
      i_pixel_top(10));
   ix2069 : xnor2 port map ( Y=>nx2068, A0=>nx2066, A1=>nx3961);
   ix2067 : xnor2 port map ( Y=>nx2066, A0=>nx1994, A1=>nx4013);
   ix1995 : mux21 port map ( Y=>nx1994, A0=>nx3999, A1=>nx3527, S0=>nx4005);
   ix4014 : xnor2 port map ( Y=>nx4013, A0=>i_pixel_top(20), A1=>
      i_pixel_top(11));
   ix2059 : xnor2 port map ( Y=>nx2058, A0=>nx4017, A1=>nx2054);
   ix4018 : xnor2 port map ( Y=>nx4017, A0=>nx4019, A1=>nx4021);
   ix4020 : mux21 port map ( Y=>nx4019, A0=>nx1994, A1=>i_pixel_top(11), S0
      =>nx4013);
   ix4022 : xnor2 port map ( Y=>nx4021, A0=>i_pixel_top(21), A1=>
      i_pixel_top(12));
   ix2049 : xnor2 port map ( Y=>nx2048, A0=>nx2046, A1=>nx3953);
   ix2047 : xnor2 port map ( Y=>nx2046, A0=>nx2002, A1=>nx4031);
   ix2003 : mux21 port map ( Y=>nx2002, A0=>nx4019, A1=>nx4028, S0=>nx4021);
   ix4029 : inv01 port map ( Y=>nx4028, A=>i_pixel_top(12));
   ix4032 : xnor2 port map ( Y=>nx4031, A0=>i_pixel_top(22), A1=>
      i_pixel_top(13));
   ix2039 : xnor2 port map ( Y=>nx2038, A0=>nx4035, A1=>nx2034);
   ix4036 : xnor2 port map ( Y=>nx4035, A0=>nx4037, A1=>nx4039);
   ix4038 : mux21 port map ( Y=>nx4037, A0=>nx2002, A1=>i_pixel_top(13), S0
      =>nx4031);
   ix4040 : xnor2 port map ( Y=>nx4039, A0=>i_pixel_top(23), A1=>
      i_pixel_top(14));
   ix2029 : xnor2 port map ( Y=>nx2028, A0=>nx4043, A1=>nx2020);
   ix4044 : xnor2 port map ( Y=>nx4043, A0=>i_pixel_top(15), A1=>nx2010);
   ix2011 : mux21 port map ( Y=>nx2010, A0=>nx4037, A1=>nx4047, S0=>nx4039);
   ix4048 : inv01 port map ( Y=>nx4047, A=>i_pixel_top(14));
   ix2021 : xnor2 port map ( Y=>nx2020, A0=>nx3825, A1=>nx1800);
   ix1945 : mux21 port map ( Y=>nx1944, A0=>nx1728, A1=>nx3825, S0=>nx1800);
   ix1947 : xnor2 port map ( Y=>nx1946, A0=>nx1728, A1=>nx4055);
   ix4056 : nand02 port map ( Y=>nx4055, A0=>i_pixel_bot(15), A1=>nx1790);
   ix4058 : xnor2 port map ( Y=>nx4057, A0=>nx4059, A1=>nx4061);
   ix4060 : nand02 port map ( Y=>nx4059, A0=>i_pixel_top(15), A1=>nx2010);
   ix4062 : xnor2 port map ( Y=>nx4061, A0=>nx1944, A1=>nx1946);
   ix2171 : nand02 port map ( Y=>nx2170, A0=>nx1728, A1=>nx2162);
   ix2163 : nand02 port map ( Y=>nx2162, A0=>nx4067, A1=>nx1728);
   ix4068 : mux21 port map ( Y=>nx4067, A0=>nx4069, A1=>nx1944, S0=>nx1946);
   ix4072 : xnor2 port map ( Y=>nx4071, A0=>nx2162, A1=>nx1728);
   derivative_reg_D_N_S_11 : dffr port map ( Q=>OPEN, QB=>nx4073, D=>nx2597, 
      CLK=>i_clock, R=>i_reset);
   ix4080 : aoi21 port map ( Y=>nx4079, A0=>nx2871, A1=>w_D_N_S_10, B0=>
      nx2192);
   ix2193 : nor03 port map ( Y=>nx2192, A0=>nx4083, A1=>nx2871, A2=>nx2172);
   ix4084 : nor02ii port map ( Y=>nx4083, A0=>nx2170, A1=>nx3819);
   derivative_reg_D_N_S_10 : dffr port map ( Q=>w_D_N_S_10, QB=>nx4085, D=>
      nx2607, CLK=>i_clock, R=>i_reset);
   ix2393 : nor02ii port map ( Y=>nx2392, A0=>nx4089, A1=>nx2390);
   ix4096 : mux21 port map ( Y=>nx4095, A0=>w_D_N_S_9, A1=>nx2210, S0=>
      i_valid);
   ix2211 : xnor2 port map ( Y=>nx2210, A0=>nx2144, A1=>nx4057);
   derivative_reg_D_N_S_9 : dffr port map ( Q=>w_D_N_S_9, QB=>nx4099, D=>
      nx2617, CLK=>i_clock, R=>i_reset);
   ix2391 : nor02ii port map ( Y=>nx2390, A0=>nx4103, A1=>nx2388);
   ix4110 : mux21 port map ( Y=>nx4109, A0=>w_D_N_S_8, A1=>nx2226, S0=>
      i_valid);
   ix2227 : xnor2 port map ( Y=>nx2226, A0=>nx3947, A1=>nx2028);
   derivative_reg_D_N_S_8 : dffr port map ( Q=>w_D_N_S_8, QB=>nx4113, D=>
      nx2627, CLK=>i_clock, R=>i_reset);
   ix2389 : nor02ii port map ( Y=>nx2388, A0=>nx4117, A1=>nx2386);
   ix4124 : mux21 port map ( Y=>nx4123, A0=>w_D_N_S_7, A1=>nx2242, S0=>
      i_valid);
   ix2243 : xor2 port map ( Y=>nx2242, A0=>nx2136, A1=>nx2038);
   derivative_reg_D_N_S_7 : dffr port map ( Q=>w_D_N_S_7, QB=>nx4127, D=>
      nx2637, CLK=>i_clock, R=>i_reset);
   ix2387 : nor02ii port map ( Y=>nx2386, A0=>nx4131, A1=>nx2384);
   ix4138 : mux21 port map ( Y=>nx4137, A0=>w_D_N_S_6, A1=>nx2258, S0=>
      i_valid);
   ix2259 : xnor2 port map ( Y=>nx2258, A0=>nx3955, A1=>nx2048);
   derivative_reg_D_N_S_6 : dffr port map ( Q=>w_D_N_S_6, QB=>nx4141, D=>
      nx2647, CLK=>i_clock, R=>i_reset);
   ix2385 : nor02ii port map ( Y=>nx2384, A0=>nx4145, A1=>nx2382);
   ix4152 : mux21 port map ( Y=>nx4151, A0=>w_D_N_S_5, A1=>nx2274, S0=>
      i_valid);
   ix2275 : xor2 port map ( Y=>nx2274, A0=>nx2128, A1=>nx2058);
   derivative_reg_D_N_S_5 : dffr port map ( Q=>w_D_N_S_5, QB=>nx4155, D=>
      nx2657, CLK=>i_clock, R=>i_reset);
   ix2383 : nor02ii port map ( Y=>nx2382, A0=>nx4159, A1=>nx2380);
   ix4166 : mux21 port map ( Y=>nx4165, A0=>w_D_N_S_4, A1=>nx2290, S0=>
      i_valid);
   ix2291 : xnor2 port map ( Y=>nx2290, A0=>nx3963, A1=>nx2068);
   derivative_reg_D_N_S_4 : dffr port map ( Q=>w_D_N_S_4, QB=>nx4169, D=>
      nx2667, CLK=>i_clock, R=>i_reset);
   ix2381 : nor02ii port map ( Y=>nx2380, A0=>nx4173, A1=>nx2378);
   ix4180 : mux21 port map ( Y=>nx4179, A0=>w_D_N_S_3, A1=>nx2306, S0=>
      i_valid);
   ix2307 : xnor2 port map ( Y=>nx2306, A0=>nx4183, A1=>nx2078);
   ix4184 : mux21 port map ( Y=>nx4183, A0=>nx2084, A1=>nx2116, S0=>nx2088);
   derivative_reg_D_N_S_3 : dffr port map ( Q=>w_D_N_S_3, QB=>nx4189, D=>
      nx2677, CLK=>i_clock, R=>i_reset);
   ix4198 : mux21 port map ( Y=>nx4197, A0=>w_D_N_S_2, A1=>nx2322, S0=>
      i_valid);
   ix2323 : xnor2 port map ( Y=>nx2322, A0=>nx3971, A1=>nx2088);
   derivative_reg_D_N_S_2 : dffr port map ( Q=>w_D_N_S_2, QB=>nx4201, D=>
      nx2687, CLK=>i_clock, R=>i_reset);
   ix4208 : mux21 port map ( Y=>nx4207, A0=>w_D_N_S_1, A1=>nx2338, S0=>
      i_valid);
   ix2339 : xnor2 port map ( Y=>nx2338, A0=>nx3799, A1=>nx2102);
   derivative_reg_D_N_S_1 : dffr port map ( Q=>w_D_N_S_1, QB=>nx4211, D=>
      nx2697, CLK=>i_clock, R=>i_reset);
   ix2591 : mux21 port map ( Y=>nx2590, A0=>nx4215, A1=>nx4217, S0=>nx4367);
   ix4218 : mux21 port map ( Y=>nx4217, A0=>nx2414, A1=>nx2574, S0=>nx4365);
   ix2415 : xnor2 port map ( Y=>nx2414, A0=>nx4089, A1=>nx2390);
   ix2575 : mux21 port map ( Y=>nx2574, A0=>nx4223, A1=>nx4225, S0=>nx4361);
   ix4226 : mux21 port map ( Y=>nx4225, A0=>nx2434, A1=>nx2558, S0=>nx4359);
   ix2435 : xnor2 port map ( Y=>nx2434, A0=>nx4117, A1=>nx2386);
   ix2559 : mux21 port map ( Y=>nx2558, A0=>nx4231, A1=>nx4233, S0=>nx4355);
   ix4234 : mux21 port map ( Y=>nx4233, A0=>nx2454, A1=>nx2542, S0=>nx4353);
   ix2455 : xnor2 port map ( Y=>nx2454, A0=>nx4145, A1=>nx2382);
   ix2543 : mux21 port map ( Y=>nx2542, A0=>nx4239, A1=>nx4345, S0=>nx2468);
   ix4240 : mux21 port map ( Y=>nx4239, A0=>nx2526, A1=>nx2474, S0=>nx2478);
   ix2527 : mux21 port map ( Y=>nx2526, A0=>nx4243, A1=>nx4327, S0=>nx2488);
   ix4244 : mux21 port map ( Y=>nx4243, A0=>nx2494, A1=>nx2510, S0=>nx4319);
   ix2495 : xnor2 port map ( Y=>nx2494, A0=>nx4247, A1=>nx2374);
   ix2511 : aoi21 port map ( Y=>nx2510, A0=>w_D_NE_SW_0, A1=>nx1630, B0=>
      nx3801);
   ix1631 : nand04 port map ( Y=>nx1630, A0=>nx4255, A1=>nx4295, A2=>nx4303, 
      A3=>nx4315);
   ix4256 : nor03 port map ( Y=>nx4255, A0=>nx1622, A1=>nx1616, A2=>nx1610);
   ix1623 : xnor2 port map ( Y=>nx1622, A0=>nx4259, A1=>nx1608);
   ix1609 : nor02ii port map ( Y=>nx1608, A0=>nx4263, A1=>nx1548);
   ix1549 : nor02ii port map ( Y=>nx1548, A0=>nx4267, A1=>nx1546);
   ix1547 : nor02ii port map ( Y=>nx1546, A0=>nx4271, A1=>nx1544);
   ix1545 : nor02ii port map ( Y=>nx1544, A0=>nx4275, A1=>nx1470);
   ix1471 : nor02ii port map ( Y=>nx1470, A0=>nx4279, A1=>nx1468);
   ix1469 : nor02ii port map ( Y=>nx1468, A0=>nx4283, A1=>nx1418);
   ix1419 : nor02ii port map ( Y=>nx1418, A0=>nx4287, A1=>nx1416);
   ix1617 : xnor2 port map ( Y=>nx1616, A0=>nx4263, A1=>nx1548);
   ix1611 : nor02ii port map ( Y=>nx1610, A0=>nx4259, A1=>nx1608);
   ix4296 : nor03 port map ( Y=>nx4295, A0=>nx1566, A1=>nx1560, A2=>nx1554);
   ix1567 : xnor2 port map ( Y=>nx1566, A0=>nx4271, A1=>nx1544);
   ix1561 : xnor2 port map ( Y=>nx1560, A0=>nx4275, A1=>nx1470);
   ix1555 : xnor2 port map ( Y=>nx1554, A0=>nx4267, A1=>nx1546);
   ix4304 : nor03 port map ( Y=>nx4303, A0=>nx1488, A1=>nx1482, A2=>nx1476);
   ix1489 : xnor2 port map ( Y=>nx1488, A0=>nx4283, A1=>nx1418);
   ix1483 : xnor2 port map ( Y=>nx1482, A0=>nx4309, A1=>nx1376);
   ix1377 : nor03 port map ( Y=>nx1376, A0=>nx5341, A1=>w_D_NE_SW_1, A2=>
      w_D_NE_SW_0);
   ix1477 : xnor2 port map ( Y=>nx1476, A0=>nx4279, A1=>nx1468);
   ix4316 : nor03 port map ( Y=>nx4315, A0=>w_D_NE_SW_0, A1=>nx1424, A2=>
      w_D_NE_SW_1);
   ix1425 : xnor2 port map ( Y=>nx1424, A0=>nx4287, A1=>nx1416);
   ix4320 : xnor2 port map ( Y=>nx4319, A0=>nx2494, A1=>nx1382);
   ix1383 : xnor2 port map ( Y=>nx1382, A0=>nx4323, A1=>nx1374);
   ix2377 : nor03 port map ( Y=>nx2376, A0=>nx5347, A1=>w_D_N_S_1, A2=>
      w_D_N_S_0);
   ix2489 : xnor2 port map ( Y=>nx2488, A0=>nx2484, A1=>nx4337);
   ix2485 : xnor2 port map ( Y=>nx2484, A0=>nx4329, A1=>nx2376);
   ix4338 : nand02 port map ( Y=>nx4337, A0=>nx1482, A1=>nx1630);
   ix2475 : xnor2 port map ( Y=>nx2474, A0=>nx4173, A1=>nx2378);
   ix2479 : xnor2 port map ( Y=>nx2478, A0=>nx2474, A1=>nx4343);
   ix4344 : nand02 port map ( Y=>nx4343, A0=>nx1424, A1=>nx1630);
   ix2469 : xnor2 port map ( Y=>nx2468, A0=>nx2464, A1=>nx4351);
   ix2465 : xnor2 port map ( Y=>nx2464, A0=>nx4159, A1=>nx2380);
   ix4352 : nand02 port map ( Y=>nx4351, A0=>nx1488, A1=>nx1630);
   ix4354 : xnor2 port map ( Y=>nx4353, A0=>nx2454, A1=>nx1476);
   ix4356 : xnor2 port map ( Y=>nx4355, A0=>nx2444, A1=>nx1560);
   ix2445 : xnor2 port map ( Y=>nx2444, A0=>nx4131, A1=>nx2384);
   ix4360 : xnor2 port map ( Y=>nx4359, A0=>nx2434, A1=>nx1566);
   ix4362 : xnor2 port map ( Y=>nx4361, A0=>nx2424, A1=>nx1554);
   ix2425 : xnor2 port map ( Y=>nx2424, A0=>nx4103, A1=>nx2388);
   ix4366 : xnor2 port map ( Y=>nx4365, A0=>nx2414, A1=>nx1616);
   ix4368 : xnor2 port map ( Y=>nx4367, A0=>nx2404, A1=>nx1622);
   ix2405 : xnor2 port map ( Y=>nx2404, A0=>nx3807, A1=>nx2392);
   ix4372 : xnor2 port map ( Y=>nx4371, A0=>nx2394, A1=>nx1610);
   ix3367 : nor02ii port map ( Y=>nx3366, A0=>nx4381, A1=>nx3364);
   ix3365 : nor02ii port map ( Y=>nx3364, A0=>nx4385, A1=>nx3362);
   ix3363 : nor02ii port map ( Y=>nx3362, A0=>nx4389, A1=>nx3360);
   ix3361 : nor02ii port map ( Y=>nx3360, A0=>nx4393, A1=>nx3358);
   ix3359 : nor02ii port map ( Y=>nx3358, A0=>nx4397, A1=>nx3356);
   ix3357 : nor02ii port map ( Y=>nx3356, A0=>nx4401, A1=>nx3354);
   ix3355 : nor02ii port map ( Y=>nx3354, A0=>nx4405, A1=>nx3352);
   ix4410 : mux21 port map ( Y=>nx4409, A0=>nx3388, A1=>nx3676, S0=>nx4563);
   ix3389 : xnor2 port map ( Y=>nx3388, A0=>nx4413, A1=>nx3366);
   ix3677 : mux21 port map ( Y=>nx3676, A0=>nx4417, A1=>nx4419, S0=>nx4555);
   ix4420 : mux21 port map ( Y=>nx4419, A0=>nx3428, A1=>nx3660, S0=>nx4549);
   ix3429 : xnor2 port map ( Y=>nx3428, A0=>nx4385, A1=>nx3362);
   ix3661 : mux21 port map ( Y=>nx3660, A0=>nx4425, A1=>nx4427, S0=>nx4541);
   ix4428 : mux21 port map ( Y=>nx4427, A0=>nx3468, A1=>nx3644, S0=>nx4535);
   ix3469 : xnor2 port map ( Y=>nx3468, A0=>nx4393, A1=>nx3358);
   ix3645 : mux21 port map ( Y=>nx3644, A0=>nx4433, A1=>nx4435, S0=>nx4527);
   ix4436 : mux21 port map ( Y=>nx4435, A0=>nx3508, A1=>nx3628, S0=>nx4521);
   ix3509 : xnor2 port map ( Y=>nx3508, A0=>nx4401, A1=>nx3354);
   ix3629 : mux21 port map ( Y=>nx3628, A0=>nx4441, A1=>nx4443, S0=>nx4513);
   ix4444 : mux21 port map ( Y=>nx4443, A0=>nx3548, A1=>nx3612, S0=>nx4507);
   ix3549 : xnor2 port map ( Y=>nx3548, A0=>nx4447, A1=>nx3350);
   ix3351 : nor03 port map ( Y=>nx3350, A0=>nx5335, A1=>w_D_E_W_1, A2=>
      w_D_E_W_0);
   ix3613 : mux21 port map ( Y=>nx3612, A0=>nx4453, A1=>nx4459, S0=>nx4497);
   ix4460 : oai21 port map ( Y=>nx4459, A0=>nx3775, A1=>nx5252, B0=>
      w_D_E_W_0);
   ix4498 : xnor2 port map ( Y=>nx4497, A0=>nx3568, A1=>nx3580);
   ix3569 : xnor2 port map ( Y=>nx3568, A0=>nx4501, A1=>nx3348);
   ix3581 : nor02 port map ( Y=>nx3580, A0=>nx5252, A1=>nx4505);
   ix4508 : xnor2 port map ( Y=>nx4507, A0=>nx3548, A1=>nx3560);
   ix3561 : nor02 port map ( Y=>nx3560, A0=>nx5252, A1=>nx4511);
   ix4514 : xnor2 port map ( Y=>nx4513, A0=>nx3528, A1=>nx3540);
   ix3529 : xnor2 port map ( Y=>nx3528, A0=>nx4405, A1=>nx3352);
   ix3541 : nor02 port map ( Y=>nx3540, A0=>nx4519, A1=>nx5252);
   ix4522 : xnor2 port map ( Y=>nx4521, A0=>nx3508, A1=>nx3520);
   ix3521 : nor02 port map ( Y=>nx3520, A0=>nx5252, A1=>nx4525);
   ix4528 : xnor2 port map ( Y=>nx4527, A0=>nx3488, A1=>nx3500);
   ix3489 : xnor2 port map ( Y=>nx3488, A0=>nx4397, A1=>nx3356);
   ix3501 : nor02 port map ( Y=>nx3500, A0=>nx5252, A1=>nx4533);
   ix4536 : xnor2 port map ( Y=>nx4535, A0=>nx3468, A1=>nx3480);
   ix3481 : nor02 port map ( Y=>nx3480, A0=>nx5254, A1=>nx4539);
   ix4542 : xnor2 port map ( Y=>nx4541, A0=>nx3448, A1=>nx3460);
   ix3449 : xnor2 port map ( Y=>nx3448, A0=>nx4389, A1=>nx3360);
   ix3461 : nor02 port map ( Y=>nx3460, A0=>nx5254, A1=>nx4547);
   ix4550 : xnor2 port map ( Y=>nx4549, A0=>nx3428, A1=>nx3440);
   ix3441 : nor02 port map ( Y=>nx3440, A0=>nx5254, A1=>nx4553);
   ix4556 : xnor2 port map ( Y=>nx4555, A0=>nx3408, A1=>nx3420);
   ix3409 : xnor2 port map ( Y=>nx3408, A0=>nx4381, A1=>nx3364);
   ix3421 : nor02 port map ( Y=>nx3420, A0=>nx5254, A1=>nx4561);
   ix4564 : xnor2 port map ( Y=>nx4563, A0=>nx3388, A1=>nx3400);
   ix3401 : nor02 port map ( Y=>nx3400, A0=>nx5254, A1=>nx4567);
   ix4570 : xnor2 port map ( Y=>nx4569, A0=>nx3368, A1=>nx3380);
   ix3369 : nor02ii port map ( Y=>nx3368, A0=>nx4413, A1=>nx3366);
   ix3381 : nor02 port map ( Y=>nx3380, A0=>nx5254, A1=>nx4575);
   ix4576 : nor02 port map ( Y=>nx4575, A0=>nx2394, A1=>nx1610);
   ix4578 : nand02 port map ( Y=>nx4577, A0=>nx2604, A1=>nx5353);
   ix725 : oai22 port map ( Y=>nx724, A0=>nx4613, A1=>nx4625, B0=>i_valid, 
      B1=>nx4607);
   ix4614 : nor03 port map ( Y=>nx4613, A0=>nx280, A1=>i_pixel_mid(16), A2=>
      nx4619);
   ix281 : aoi21 port map ( Y=>nx280, A0=>nx76, A1=>nx4617, B0=>
      i_pixel_mid(0));
   ix4618 : nand02 port map ( Y=>nx4617, A0=>i_pixel_top(8), A1=>nx3501);
   ix4626 : nand02 port map ( Y=>nx4625, A0=>i_valid, A1=>nx4627);
   ix4628 : oai21 port map ( Y=>nx4627, A0=>nx4619, A1=>nx280, B0=>
      i_pixel_mid(16));
   derivative_reg_D_NW_SE_0 : dffr port map ( Q=>w_D_NW_SE_0, QB=>nx4607, D
      =>nx2457, CLK=>i_clock, R=>i_reset);
   ix3891 : xnor2 port map ( Y=>nx3890, A0=>nx4631, A1=>nx732);
   ix4636 : mux21 port map ( Y=>nx4635, A0=>nx5220, A1=>nx554, S0=>i_valid);
   ix555 : xnor2 port map ( Y=>nx554, A0=>nx550, A1=>nx4845);
   ix551 : nor02ii port map ( Y=>nx550, A0=>nx4639, A1=>nx548);
   ix4640 : mux21 port map ( Y=>nx4639, A0=>nx522, A1=>nx326, S0=>nx4833);
   ix523 : mux21 port map ( Y=>nx522, A0=>nx4642, A1=>nx4753, S0=>nx406);
   ix4645 : mux21 port map ( Y=>nx4644, A0=>nx314, A1=>nx4734, S0=>nx4740);
   ix315 : mux21 port map ( Y=>nx314, A0=>nx4647, A1=>nx198, S0=>nx4728);
   ix4648 : mux21 port map ( Y=>nx4647, A0=>nx306, A1=>nx4710, S0=>nx4716);
   ix307 : mux21 port map ( Y=>nx306, A0=>nx4651, A1=>nx222, S0=>nx4704);
   ix4652 : mux21 port map ( Y=>nx4651, A0=>nx298, A1=>nx4683, S0=>nx4692);
   ix299 : mux21 port map ( Y=>nx298, A0=>nx246, A1=>nx4661, S0=>nx250);
   ix4657 : nand02 port map ( Y=>nx4656, A0=>i_pixel_mid(1), A1=>
      i_pixel_bot(0));
   ix4660 : xnor2 port map ( Y=>nx4659, A0=>i_pixel_mid(2), A1=>
      i_pixel_bot(1));
   ix4662 : mux21 port map ( Y=>nx4661, A0=>nx290, A1=>nx4665, S0=>nx4667);
   ix291 : nand03 port map ( Y=>nx290, A0=>nx4617, A1=>i_pixel_mid(0), A2=>
      nx76);
   ix4666 : oai21 port map ( Y=>nx4665, A0=>i_pixel_bot(0), A1=>
      i_pixel_mid(1), B0=>nx4656);
   ix4668 : xnor2 port map ( Y=>nx4667, A0=>nx264, A1=>nx4665);
   ix265 : xnor2 port map ( Y=>nx264, A0=>nx4671, A1=>nx62);
   ix63 : xnor2 port map ( Y=>nx62, A0=>i_pixel_bot(9), A1=>i_pixel_top(9));
   ix251 : xnor2 port map ( Y=>nx250, A0=>nx4677, A1=>nx4681);
   ix4678 : xnor2 port map ( Y=>nx4677, A0=>nx82, A1=>nx54);
   ix83 : mux21 port map ( Y=>nx82, A0=>i_pixel_bot(9), A1=>nx4671, S0=>nx62
   );
   ix55 : xnor2 port map ( Y=>nx54, A0=>i_pixel_bot(10), A1=>i_pixel_top(10)
   );
   ix4682 : xnor2 port map ( Y=>nx4681, A0=>nx4656, A1=>nx4659);
   ix4684 : xnor2 port map ( Y=>nx4683, A0=>nx4685, A1=>nx4690);
   ix4686 : aoi32 port map ( Y=>nx4685, A0=>i_pixel_mid(1), A1=>
      i_pixel_bot(0), A2=>nx138, B0=>i_pixel_bot(1), B1=>i_pixel_mid(2));
   ix4691 : xnor2 port map ( Y=>nx4690, A0=>i_pixel_mid(3), A1=>
      i_pixel_bot(2));
   ix4693 : xnor2 port map ( Y=>nx4692, A0=>nx236, A1=>nx4683);
   ix237 : xnor2 port map ( Y=>nx236, A0=>nx4695, A1=>nx46);
   ix4696 : aoi22 port map ( Y=>nx4695, A0=>nx3885, A1=>i_pixel_top(10), B0
      =>nx82, B1=>nx54);
   ix47 : xnor2 port map ( Y=>nx46, A0=>i_pixel_bot(11), A1=>i_pixel_top(11)
   );
   ix223 : xnor2 port map ( Y=>nx222, A0=>nx152, A1=>nx4702);
   ix153 : mux21 port map ( Y=>nx152, A0=>nx4685, A1=>nx4700, S0=>nx4690);
   ix4701 : inv01 port map ( Y=>nx4700, A=>i_pixel_bot(2));
   ix4703 : xnor2 port map ( Y=>nx4702, A0=>i_pixel_mid(4), A1=>
      i_pixel_bot(3));
   ix4705 : xnor2 port map ( Y=>nx4704, A0=>nx4706, A1=>nx222);
   ix4707 : xnor2 port map ( Y=>nx4706, A0=>nx90, A1=>nx38);
   ix91 : mux21 port map ( Y=>nx90, A0=>i_pixel_bot(11), A1=>nx4695, S0=>
      nx46);
   ix39 : xnor2 port map ( Y=>nx38, A0=>i_pixel_bot(12), A1=>i_pixel_top(12)
   );
   ix4711 : xnor2 port map ( Y=>nx4710, A0=>nx4712, A1=>nx4714);
   ix4713 : mux21 port map ( Y=>nx4712, A0=>nx152, A1=>i_pixel_bot(3), S0=>
      nx4702);
   ix4715 : xnor2 port map ( Y=>nx4714, A0=>i_pixel_mid(5), A1=>
      i_pixel_bot(4));
   ix4717 : xnor2 port map ( Y=>nx4716, A0=>nx212, A1=>nx4710);
   ix213 : xnor2 port map ( Y=>nx212, A0=>nx4719, A1=>nx30);
   ix4720 : aoi22 port map ( Y=>nx4719, A0=>nx3913, A1=>i_pixel_top(12), B0
      =>nx90, B1=>nx38);
   ix31 : xnor2 port map ( Y=>nx30, A0=>i_pixel_bot(13), A1=>i_pixel_top(13)
   );
   ix199 : xnor2 port map ( Y=>nx198, A0=>nx160, A1=>nx4726);
   ix161 : mux21 port map ( Y=>nx160, A0=>nx4712, A1=>nx4724, S0=>nx4714);
   ix4725 : inv01 port map ( Y=>nx4724, A=>i_pixel_bot(4));
   ix4727 : xnor2 port map ( Y=>nx4726, A0=>i_pixel_mid(6), A1=>
      i_pixel_bot(5));
   ix4729 : xnor2 port map ( Y=>nx4728, A0=>nx4730, A1=>nx198);
   ix4731 : xnor2 port map ( Y=>nx4730, A0=>nx98, A1=>nx22);
   ix99 : mux21 port map ( Y=>nx98, A0=>i_pixel_bot(13), A1=>nx4719, S0=>
      nx30);
   ix23 : xnor2 port map ( Y=>nx22, A0=>i_pixel_bot(14), A1=>i_pixel_top(14)
   );
   ix4735 : xnor2 port map ( Y=>nx4734, A0=>nx4736, A1=>nx4738);
   ix4737 : mux21 port map ( Y=>nx4736, A0=>nx160, A1=>i_pixel_bot(5), S0=>
      nx4726);
   ix4739 : xnor2 port map ( Y=>nx4738, A0=>i_pixel_mid(7), A1=>
      i_pixel_bot(6));
   ix4741 : xnor2 port map ( Y=>nx4740, A0=>nx188, A1=>nx4734);
   ix189 : xnor2 port map ( Y=>nx188, A0=>nx4743, A1=>nx14);
   ix4744 : aoi22 port map ( Y=>nx4743, A0=>nx3945, A1=>i_pixel_top(14), B0
      =>nx98, B1=>nx22);
   ix15 : xnor2 port map ( Y=>nx14, A0=>i_pixel_bot(15), A1=>i_pixel_top(15)
   );
   ix179 : xnor2 port map ( Y=>nx178, A0=>nx106, A1=>nx4748);
   ix107 : mux21 port map ( Y=>nx106, A0=>i_pixel_bot(15), A1=>nx4743, S0=>
      nx14);
   ix4749 : xnor2 port map ( Y=>nx4748, A0=>i_pixel_bot(7), A1=>nx168);
   ix169 : mux21 port map ( Y=>nx168, A0=>nx4736, A1=>nx4751, S0=>nx4738);
   ix4752 : inv01 port map ( Y=>nx4751, A=>i_pixel_bot(6));
   ix4754 : mux21 port map ( Y=>nx4753, A0=>nx412, A1=>nx514, S0=>nx416);
   ix413 : xnor2 port map ( Y=>nx412, A0=>nx314, A1=>nx4740);
   ix515 : mux21 port map ( Y=>nx514, A0=>nx4757, A1=>nx4759, S0=>nx426);
   ix4758 : xnor2 port map ( Y=>nx4757, A0=>nx4647, A1=>nx4728);
   ix4760 : mux21 port map ( Y=>nx4759, A0=>nx432, A1=>nx506, S0=>nx436);
   ix433 : xnor2 port map ( Y=>nx432, A0=>nx306, A1=>nx4716);
   ix507 : mux21 port map ( Y=>nx506, A0=>nx4763, A1=>nx4765, S0=>nx446);
   ix4764 : xnor2 port map ( Y=>nx4763, A0=>nx4651, A1=>nx4704);
   ix4766 : mux21 port map ( Y=>nx4765, A0=>nx452, A1=>nx498, S0=>nx456);
   ix453 : xnor2 port map ( Y=>nx452, A0=>nx298, A1=>nx4692);
   ix4772 : mux21 port map ( Y=>nx4771, A0=>nx472, A1=>nx490, S0=>nx480);
   ix473 : xnor2 port map ( Y=>nx472, A0=>nx290, A1=>nx4667);
   ix289 : nand03 port map ( Y=>nx288, A0=>nx4617, A1=>i_pixel_mid(0), A2=>
      nx76);
   ix481 : xnor2 port map ( Y=>nx480, A0=>nx4779, A1=>nx472);
   ix4780 : oai21 port map ( Y=>nx4779, A0=>i_pixel_top(16), A1=>
      i_pixel_mid(17), B0=>nx4781);
   ix4782 : nand02 port map ( Y=>nx4781, A0=>i_pixel_mid(17), A1=>
      i_pixel_top(16));
   ix467 : xnor2 port map ( Y=>nx466, A0=>nx4784, A1=>nx462);
   ix4785 : xnor2 port map ( Y=>nx4784, A0=>nx4781, A1=>nx4786);
   ix4787 : xnor2 port map ( Y=>nx4786, A0=>i_pixel_mid(18), A1=>
      i_pixel_top(17));
   ix463 : xnor2 port map ( Y=>nx462, A0=>nx4661, A1=>nx250);
   ix457 : xnor2 port map ( Y=>nx456, A0=>nx4790, A1=>nx452);
   ix4791 : xnor2 port map ( Y=>nx4790, A0=>nx4792, A1=>nx4797);
   ix4793 : aoi32 port map ( Y=>nx4792, A0=>i_pixel_mid(17), A1=>
      i_pixel_top(16), A2=>nx358, B0=>i_pixel_top(17), B1=>i_pixel_mid(18));
   ix4798 : xnor2 port map ( Y=>nx4797, A0=>i_pixel_mid(19), A1=>
      i_pixel_top(18));
   ix447 : xnor2 port map ( Y=>nx446, A0=>nx444, A1=>nx4763);
   ix445 : xnor2 port map ( Y=>nx444, A0=>nx372, A1=>nx4802);
   ix373 : mux21 port map ( Y=>nx372, A0=>nx4792, A1=>nx2991, S0=>nx4797);
   ix4803 : xnor2 port map ( Y=>nx4802, A0=>i_pixel_mid(20), A1=>
      i_pixel_top(19));
   ix437 : xnor2 port map ( Y=>nx436, A0=>nx4805, A1=>nx432);
   ix4806 : xnor2 port map ( Y=>nx4805, A0=>nx4807, A1=>nx4809);
   ix4808 : mux21 port map ( Y=>nx4807, A0=>nx372, A1=>i_pixel_top(19), S0=>
      nx4802);
   ix4810 : xnor2 port map ( Y=>nx4809, A0=>i_pixel_mid(21), A1=>
      i_pixel_top(20));
   ix427 : xnor2 port map ( Y=>nx426, A0=>nx424, A1=>nx4757);
   ix425 : xnor2 port map ( Y=>nx424, A0=>nx380, A1=>nx4814);
   ix381 : mux21 port map ( Y=>nx380, A0=>nx4807, A1=>nx3023, S0=>nx4809);
   ix4815 : xnor2 port map ( Y=>nx4814, A0=>i_pixel_mid(22), A1=>
      i_pixel_top(21));
   ix417 : xnor2 port map ( Y=>nx416, A0=>nx4817, A1=>nx412);
   ix4818 : xnor2 port map ( Y=>nx4817, A0=>nx4819, A1=>nx4821);
   ix4820 : mux21 port map ( Y=>nx4819, A0=>nx380, A1=>i_pixel_top(21), S0=>
      nx4814);
   ix4822 : xnor2 port map ( Y=>nx4821, A0=>i_pixel_mid(23), A1=>
      i_pixel_top(22));
   ix407 : xnor2 port map ( Y=>nx406, A0=>nx4824, A1=>nx398);
   ix4825 : xnor2 port map ( Y=>nx4824, A0=>i_pixel_top(23), A1=>nx388);
   ix389 : mux21 port map ( Y=>nx388, A0=>nx4819, A1=>nx3049, S0=>nx4821);
   ix399 : xnor2 port map ( Y=>nx398, A0=>nx4644, A1=>nx178);
   ix323 : mux21 port map ( Y=>nx322, A0=>nx106, A1=>nx4644, S0=>nx178);
   ix325 : xnor2 port map ( Y=>nx324, A0=>nx106, A1=>nx4831);
   ix4832 : nand02 port map ( Y=>nx4831, A0=>i_pixel_bot(7), A1=>nx168);
   ix4834 : xnor2 port map ( Y=>nx4833, A0=>nx4835, A1=>nx4837);
   ix4836 : nand02 port map ( Y=>nx4835, A0=>i_pixel_top(23), A1=>nx388);
   ix4838 : xnor2 port map ( Y=>nx4837, A0=>nx322, A1=>nx324);
   ix549 : nand02 port map ( Y=>nx548, A0=>nx106, A1=>nx540);
   ix541 : nand02 port map ( Y=>nx540, A0=>nx4841, A1=>nx106);
   ix4842 : mux21 port map ( Y=>nx4841, A0=>nx4843, A1=>nx322, S0=>nx324);
   ix4846 : xnor2 port map ( Y=>nx4845, A0=>nx540, A1=>nx106);
   derivative_reg_D_NW_SE_11 : dffr port map ( Q=>OPEN, QB=>nx4847, D=>
      nx2357, CLK=>i_clock, R=>i_reset);
   ix4852 : mux21 port map ( Y=>nx4851, A0=>w_D_NW_SE_1, A1=>nx696, S0=>
      i_valid);
   ix697 : xnor2 port map ( Y=>nx696, A0=>nx4627, A1=>nx480);
   derivative_reg_D_NW_SE_1 : dffr port map ( Q=>w_D_NW_SE_1, QB=>nx4854, D
      =>nx2447, CLK=>i_clock, R=>i_reset);
   ix3905 : xnor2 port map ( Y=>nx3904, A0=>nx3890, A1=>nx4858);
   ix4859 : nand02 port map ( Y=>nx4858, A0=>nx5294, A1=>nx3898);
   ix4868 : mux21 port map ( Y=>nx4867, A0=>w_D_NW_SE_2, A1=>nx680, S0=>
      i_valid);
   ix681 : xnor2 port map ( Y=>nx680, A0=>nx4771, A1=>nx466);
   derivative_reg_D_NW_SE_2 : dffr port map ( Q=>w_D_NW_SE_2, QB=>nx4870, D
      =>nx2437, CLK=>i_clock, R=>i_reset);
   ix735 : nor03 port map ( Y=>nx734, A0=>nx5359, A1=>w_D_NW_SE_1, A2=>
      w_D_NW_SE_0);
   ix3885 : xnor2 port map ( Y=>nx3884, A0=>nx3870, A1=>nx4875);
   ix3871 : xnor2 port map ( Y=>nx3870, A0=>nx4863, A1=>nx734);
   ix4876 : nand02 port map ( Y=>nx4875, A0=>nx5294, A1=>nx3878);
   ix3851 : xnor2 port map ( Y=>nx3850, A0=>nx4881, A1=>nx736);
   ix4886 : mux21 port map ( Y=>nx4885, A0=>w_D_NW_SE_3, A1=>nx664, S0=>
      i_valid);
   ix665 : xnor2 port map ( Y=>nx664, A0=>nx4888, A1=>nx456);
   ix4889 : mux21 port map ( Y=>nx4888, A0=>nx462, A1=>nx494, S0=>nx466);
   derivative_reg_D_NW_SE_3 : dffr port map ( Q=>w_D_NW_SE_3, QB=>nx4893, D
      =>nx2427, CLK=>i_clock, R=>i_reset);
   ix3865 : xnor2 port map ( Y=>nx3864, A0=>nx3850, A1=>nx4897);
   ix4898 : nand02 port map ( Y=>nx4897, A0=>nx3858, A1=>nx5294);
   ix4907 : mux21 port map ( Y=>nx4906, A0=>w_D_NW_SE_4, A1=>nx648, S0=>
      i_valid);
   ix649 : xnor2 port map ( Y=>nx648, A0=>nx4765, A1=>nx446);
   derivative_reg_D_NW_SE_4 : dffr port map ( Q=>w_D_NW_SE_4, QB=>nx4909, D
      =>nx2417, CLK=>i_clock, R=>i_reset);
   ix739 : nor02ii port map ( Y=>nx738, A0=>nx4881, A1=>nx736);
   ix3845 : xnor2 port map ( Y=>nx3844, A0=>nx3830, A1=>nx4914);
   ix3831 : xnor2 port map ( Y=>nx3830, A0=>nx4902, A1=>nx738);
   ix4915 : nand02 port map ( Y=>nx4914, A0=>nx5294, A1=>nx3838);
   ix3811 : xnor2 port map ( Y=>nx3810, A0=>nx4918, A1=>nx740);
   ix4923 : mux21 port map ( Y=>nx4922, A0=>w_D_NW_SE_5, A1=>nx632, S0=>
      i_valid);
   ix633 : xor2 port map ( Y=>nx632, A0=>nx506, A1=>nx436);
   derivative_reg_D_NW_SE_5 : dffr port map ( Q=>w_D_NW_SE_5, QB=>nx4925, D
      =>nx2407, CLK=>i_clock, R=>i_reset);
   ix741 : nor02ii port map ( Y=>nx740, A0=>nx4902, A1=>nx738);
   ix3825 : xnor2 port map ( Y=>nx3824, A0=>nx3810, A1=>nx4929);
   ix4930 : nand02 port map ( Y=>nx4929, A0=>nx5294, A1=>nx3818);
   ix4939 : mux21 port map ( Y=>nx4938, A0=>w_D_NW_SE_6, A1=>nx616, S0=>
      i_valid);
   ix617 : xnor2 port map ( Y=>nx616, A0=>nx4759, A1=>nx426);
   derivative_reg_D_NW_SE_6 : dffr port map ( Q=>w_D_NW_SE_6, QB=>nx4941, D
      =>nx2397, CLK=>i_clock, R=>i_reset);
   ix743 : nor02ii port map ( Y=>nx742, A0=>nx4918, A1=>nx740);
   ix3805 : xnor2 port map ( Y=>nx3804, A0=>nx3790, A1=>nx4946);
   ix3791 : xnor2 port map ( Y=>nx3790, A0=>nx4934, A1=>nx742);
   ix4947 : nand02 port map ( Y=>nx4946, A0=>nx5296, A1=>nx3798);
   ix3771 : xnor2 port map ( Y=>nx3770, A0=>nx4950, A1=>nx744);
   ix4955 : mux21 port map ( Y=>nx4954, A0=>w_D_NW_SE_7, A1=>nx600, S0=>
      i_valid);
   ix601 : xor2 port map ( Y=>nx600, A0=>nx514, A1=>nx416);
   derivative_reg_D_NW_SE_7 : dffr port map ( Q=>w_D_NW_SE_7, QB=>nx4957, D
      =>nx2387, CLK=>i_clock, R=>i_reset);
   ix745 : nor02ii port map ( Y=>nx744, A0=>nx4934, A1=>nx742);
   ix3785 : xnor2 port map ( Y=>nx3784, A0=>nx3770, A1=>nx4961);
   ix4962 : nand02 port map ( Y=>nx4961, A0=>nx5296, A1=>nx3778);
   ix4971 : mux21 port map ( Y=>nx4970, A0=>w_D_NW_SE_8, A1=>nx584, S0=>
      i_valid);
   ix585 : xnor2 port map ( Y=>nx584, A0=>nx4753, A1=>nx406);
   derivative_reg_D_NW_SE_8 : dffr port map ( Q=>w_D_NW_SE_8, QB=>nx4973, D
      =>nx2377, CLK=>i_clock, R=>i_reset);
   ix747 : nor02ii port map ( Y=>nx746, A0=>nx4950, A1=>nx744);
   ix3765 : xnor2 port map ( Y=>nx3764, A0=>nx3750, A1=>nx4978);
   ix3751 : xnor2 port map ( Y=>nx3750, A0=>nx4966, A1=>nx746);
   ix4979 : nand02 port map ( Y=>nx4978, A0=>nx5296, A1=>nx3758);
   ix757 : xnor2 port map ( Y=>nx756, A0=>nx4982, A1=>nx748);
   ix4987 : mux21 port map ( Y=>nx4986, A0=>w_D_NW_SE_9, A1=>nx568, S0=>
      i_valid);
   ix569 : xnor2 port map ( Y=>nx568, A0=>nx522, A1=>nx4833);
   derivative_reg_D_NW_SE_9 : dffr port map ( Q=>w_D_NW_SE_9, QB=>nx4989, D
      =>nx2367, CLK=>i_clock, R=>i_reset);
   ix749 : nor02ii port map ( Y=>nx748, A0=>nx4966, A1=>nx746);
   ix3745 : xnor2 port map ( Y=>nx3744, A0=>nx756, A1=>nx4993);
   ix4994 : nand02 port map ( Y=>nx4993, A0=>nx5296, A1=>nx3738);
   ix5003 : aoi21 port map ( Y=>nx5002, A0=>nx2871, A1=>w_D_NW_SE_10, B0=>
      nx764);
   ix765 : nor03 port map ( Y=>nx764, A0=>nx5005, A1=>nx2871, A2=>nx550);
   ix5006 : nor02ii port map ( Y=>nx5005, A0=>nx548, A1=>nx4639);
   derivative_reg_D_NW_SE_10 : dffr port map ( Q=>w_D_NW_SE_10, QB=>nx5007, 
      D=>nx2467, CLK=>i_clock, R=>i_reset);
   ix751 : nor02ii port map ( Y=>nx750, A0=>nx4982, A1=>nx748);
   ix3731 : xnor2 port map ( Y=>nx3730, A0=>nx3716, A1=>nx5012);
   ix3717 : xnor2 port map ( Y=>nx3716, A0=>nx4998, A1=>nx750);
   ix5013 : nand02 port map ( Y=>nx5012, A0=>nx5296, A1=>nx3724);
   ix779 : nor02ii port map ( Y=>nx778, A0=>nx4998, A1=>nx750);
   ix3711 : xnor2 port map ( Y=>nx3710, A0=>nx778, A1=>nx5017);
   ix5018 : nand02 port map ( Y=>nx5017, A0=>nx5296, A1=>nx3704);
   ix5022 : mux21 port map ( Y=>nx5021, A0=>nx4552, A1=>nx4600, S0=>nx4408);
   ix4553 : nand02 port map ( Y=>nx4552, A0=>nx5024, A1=>nx5359);
   ix5025 : nand04 port map ( Y=>nx5024, A0=>nx4530, A1=>nx4540, A2=>nx4854, 
      A3=>nx4607);
   ix4601 : nand02 port map ( Y=>nx4600, A0=>nx5031, A1=>nx5347);
   ix5032 : nand04 port map ( Y=>nx5031, A0=>nx4578, A1=>nx4588, A2=>nx4211, 
      A3=>nx3801);
   ix4401 : oai21 port map ( Y=>nx4400, A0=>nx5290, A1=>nx5264, B0=>nx5038);
   ix5068 : nand02 port map ( Y=>nx5067, A0=>nx3696, A1=>nx3749);
   ix4345 : nor04 port map ( Y=>nx4344, A0=>nx4284, A1=>nx4316, A2=>nx4330, 
      A3=>nx4336);
   ix4285 : xnor2 port map ( Y=>nx4284, A0=>nx4260, A1=>nx5168);
   ix4261 : mux21 port map ( Y=>nx4260, A0=>nx5078, A1=>nx5161, S0=>nx5164);
   ix5079 : mux21 port map ( Y=>nx5078, A0=>nx4252, A1=>nx4084, S0=>nx5154);
   ix4253 : mux21 port map ( Y=>nx4252, A0=>nx5081, A1=>nx5142, S0=>nx5145);
   ix4147 : nand02 port map ( Y=>nx4146, A0=>nx5084, A1=>nx5092);
   ix5085 : aoi221 port map ( Y=>nx5084, A0=>nx1560, A1=>nx5278, B0=>nx3468, 
      B1=>nx5274, C0=>nx4134);
   ix5093 : aoi22 port map ( Y=>nx5092, A0=>nx3858, A1=>nx5266, B0=>nx3850, 
      B1=>nx5278);
   ix5102 : aoi22 port map ( Y=>nx5101, A0=>nx2454, A1=>nx5272, B0=>nx3810, 
      B1=>nx5268);
   ix5108 : aoi22 port map ( Y=>nx5107, A0=>nx2444, A1=>nx5272, B0=>nx3790, 
      B1=>nx5268);
   ix4177 : aoi22 port map ( Y=>nx4176, A0=>nx5110, A1=>nx5113, B0=>nx5084, 
      B1=>nx5092);
   ix5111 : aoi221 port map ( Y=>nx5110, A0=>nx1476, A1=>nx5278, B0=>nx3488, 
      B1=>nx5274, C0=>nx4158);
   ix5114 : aoi22 port map ( Y=>nx5113, A0=>nx3878, A1=>nx5266, B0=>nx3870, 
      B1=>nx5278);
   ix4243 : oai21 port map ( Y=>nx4242, A0=>nx5116, A1=>nx5125, B0=>nx5127);
   ix5117 : aoi221 port map ( Y=>nx5116, A0=>nx3890, A1=>nx5278, B0=>nx3918, 
      B1=>nx4182, C0=>nx4202);
   ix4203 : oai21 port map ( Y=>nx4202, A0=>nx5120, A1=>nx5300, B0=>nx5123);
   ix5124 : aoi33 port map ( Y=>nx5123, A0=>nx5280, A1=>nx1424, A2=>
      w_D_NW_SE_0, B0=>nx5274, B1=>nx3528, B2=>nx3918);
   ix5126 : aoi222 port map ( Y=>nx5125, A0=>nx2464, A1=>nx5272, B0=>nx3830, 
      B1=>nx5268, C0=>nx3508, C1=>nx5274);
   ix5128 : aoi32 port map ( Y=>nx5127, A0=>nx4220, A1=>nx1488, A2=>nx5280, 
      B0=>nx4232, B1=>nx4236);
   ix4233 : oai21 port map ( Y=>nx4232, A0=>nx5120, A1=>nx5300, B0=>nx5134);
   ix5135 : oai21 port map ( Y=>nx5134, A0=>nx3890, A1=>nx1488, B0=>nx5280);
   ix4237 : oai21 port map ( Y=>nx4236, A0=>nx5137, A1=>nx5140, B0=>nx5123);
   ix5141 : aoi22 port map ( Y=>nx5140, A0=>nx2474, A1=>nx5272, B0=>nx3850, 
      B1=>nx5268);
   ix5143 : aoi221 port map ( Y=>nx5142, A0=>nx1566, A1=>nx5280, B0=>nx3448, 
      B1=>nx5274, C0=>nx4102);
   ix4103 : ao22 port map ( Y=>nx4102, A0=>nx2434, A1=>nx5272, B0=>nx3770, 
      B1=>nx5268);
   ix5146 : xnor2 port map ( Y=>nx5145, A0=>nx5147, A1=>nx5142);
   ix5148 : aoi22 port map ( Y=>nx5147, A0=>nx3838, A1=>nx5266, B0=>nx3830, 
      B1=>nx5280);
   ix5153 : aoi22 port map ( Y=>nx5152, A0=>nx2424, A1=>nx5272, B0=>nx3750, 
      B1=>nx5268);
   ix5155 : xnor2 port map ( Y=>nx5154, A0=>nx5156, A1=>nx5158);
   ix5157 : aoi22 port map ( Y=>nx5156, A0=>nx3818, A1=>nx5266, B0=>nx3810, 
      B1=>nx5280);
   ix5159 : aoi221 port map ( Y=>nx5158, A0=>nx1554, A1=>nx5282, B0=>nx3428, 
      B1=>nx5274, C0=>nx4076);
   ix5162 : aoi221 port map ( Y=>nx5161, A0=>nx1616, A1=>nx5282, B0=>nx3408, 
      B1=>nx5276, C0=>nx4040);
   ix4041 : ao22 port map ( Y=>nx4040, A0=>nx2414, A1=>nx4036, B0=>nx756, B1
      =>nx5270);
   ix5165 : xnor2 port map ( Y=>nx5164, A0=>nx5166, A1=>nx5161);
   ix5167 : aoi22 port map ( Y=>nx5166, A0=>nx3798, A1=>nx5266, B0=>nx3790, 
      B1=>nx5282);
   ix5169 : xnor2 port map ( Y=>nx5168, A0=>nx5170, A1=>nx5172);
   ix5171 : aoi22 port map ( Y=>nx5170, A0=>nx3778, A1=>nx5266, B0=>nx3770, 
      B1=>nx5282);
   ix5173 : aoi221 port map ( Y=>nx5172, A0=>nx1622, A1=>nx5282, B0=>nx3388, 
      B1=>nx5276, C0=>nx4272);
   ix4317 : xor2 port map ( Y=>nx4316, A0=>nx5176, A1=>nx5183);
   ix5177 : mux21 port map ( Y=>nx5176, A0=>nx4260, A1=>nx4280, S0=>nx5168);
   ix5182 : aoi22 port map ( Y=>nx5181, A0=>nx2404, A1=>nx4036, B0=>nx3716, 
      B1=>nx5270);
   ix5184 : xnor2 port map ( Y=>nx5183, A0=>nx5185, A1=>nx5187);
   ix5186 : aoi22 port map ( Y=>nx5185, A0=>nx3758, A1=>nx5331, B0=>nx3750, 
      B1=>nx5282);
   ix5188 : aoi221 port map ( Y=>nx5187, A0=>nx1610, A1=>nx5284, B0=>nx3368, 
      B1=>nx5276, C0=>nx4304);
   ix4305 : ao22 port map ( Y=>nx4304, A0=>nx2394, A1=>nx4036, B0=>nx778, B1
      =>nx5270);
   ix4331 : mux21 port map ( Y=>nx4330, A0=>nx5176, A1=>nx5187, S0=>nx5183);
   ix4337 : ao22 port map ( Y=>nx4336, A0=>nx3738, A1=>nx5331, B0=>nx756, B1
      =>nx5284);
   ix4361 : oai21 port map ( Y=>nx4360, A0=>nx4348, A1=>nx4350, B0=>nx4346);
   ix4349 : xnor2 port map ( Y=>nx4348, A0=>nx4248, A1=>nx5145);
   ix4249 : oai321 port map ( Y=>nx4248, A0=>nx5195, A1=>nx5113, A2=>nx5110, 
      B0=>nx5092, B1=>nx5084, C0=>nx5197);
   ix5198 : nand02 port map ( Y=>nx5197, A0=>nx4176, A1=>nx4242);
   ix4351 : xnor2 port map ( Y=>nx4350, A0=>nx4252, A1=>nx5154);
   ix4347 : xor2 port map ( Y=>nx4346, A0=>nx5078, A1=>nx5164);
   ix5202 : aoi22 port map ( Y=>nx5201, A0=>nx3724, A1=>nx5331, B0=>nx3716, 
      B1=>nx5284);
   ix5204 : aoi21 port map ( Y=>nx5203, A0=>nx3704, A1=>nx5298, B0=>nx778);
   ix5214 : nand04 port map ( Y=>o_edge_dup0, A0=>nx4344, A1=>nx4360, A2=>
      nx5201, A3=>nx5203);
   ix4389 : inv01 port map ( Y=>nx4388, A=>o_edge_dup0);
   ix4281 : inv01 port map ( Y=>nx4280, A=>nx5172);
   ix4273 : inv01 port map ( Y=>nx4272, A=>nx5181);
   ix5082 : inv01 port map ( Y=>nx5081, A=>nx4248);
   ix4183 : inv01 port map ( Y=>nx4182, A=>nx5140);
   ix4159 : inv01 port map ( Y=>nx4158, A=>nx5101);
   ix5196 : inv01 port map ( Y=>nx5195, A=>nx4146);
   ix4135 : inv01 port map ( Y=>nx4134, A=>nx5107);
   ix4085 : inv01 port map ( Y=>nx4084, A=>nx5158);
   ix4077 : inv01 port map ( Y=>nx4076, A=>nx5152);
   ix5138 : inv01 port map ( Y=>nx5137, A=>nx3918);
   ix5121 : inv01 port map ( Y=>nx5120, A=>nx3898);
   ix4862 : inv01 port map ( Y=>nx4861, A=>nx3870);
   ix4901 : inv01 port map ( Y=>nx4900, A=>nx3830);
   ix4933 : inv01 port map ( Y=>nx4932, A=>nx3790);
   ix4965 : inv01 port map ( Y=>nx4964, A=>nx3750);
   ix4997 : inv01 port map ( Y=>nx4996, A=>nx3716);
   ix3697 : inv01 port map ( Y=>nx3696, A=>nx4577);
   ix4454 : inv01 port map ( Y=>nx4453, A=>nx3568);
   ix4879 : inv01 port map ( Y=>nx4878, A=>nx3548);
   ix4442 : inv01 port map ( Y=>nx4441, A=>nx3528);
   ix4602 : inv01 port map ( Y=>nx4601, A=>nx3508);
   ix4434 : inv01 port map ( Y=>nx4433, A=>nx3488);
   ix4596 : inv01 port map ( Y=>nx4595, A=>nx3468);
   ix4426 : inv01 port map ( Y=>nx4425, A=>nx3448);
   ix4590 : inv01 port map ( Y=>nx4589, A=>nx3428);
   ix4418 : inv01 port map ( Y=>nx4417, A=>nx3408);
   ix4584 : inv01 port map ( Y=>nx4583, A=>nx3388);
   ix4376 : inv01 port map ( Y=>nx4375, A=>nx3368);
   ix3095 : inv01 port map ( Y=>nx3094, A=>nx3283);
   ix3091 : inv01 port map ( Y=>nx3090, A=>nx3079);
   ix3087 : inv01 port map ( Y=>nx3086, A=>nx3289);
   ix3206 : inv01 port map ( Y=>nx3205, A=>nx2994);
   ix2955 : inv01 port map ( Y=>nx2954, A=>nx3107);
   ix2923 : inv01 port map ( Y=>nx2922, A=>nx3213);
   ix2843 : inv01 port map ( Y=>nx2842, A=>nx2973);
   ix2735 : inv01 port map ( Y=>nx2734, A=>nx2941);
   ix3196 : inv01 port map ( Y=>nx3195, A=>nx2702);
   ix2599 : inv01 port map ( Y=>nx2598, A=>nx3803);
   ix4328 : inv01 port map ( Y=>nx4327, A=>nx2484);
   ix4346 : inv01 port map ( Y=>nx4345, A=>nx2464);
   ix4232 : inv01 port map ( Y=>nx4231, A=>nx2444);
   ix4224 : inv01 port map ( Y=>nx4223, A=>nx2424);
   ix4216 : inv01 port map ( Y=>nx4215, A=>nx2404);
   ix2121 : inv01 port map ( Y=>nx2120, A=>nx4183);
   ix2117 : inv01 port map ( Y=>nx2116, A=>nx3971);
   ix2113 : inv01 port map ( Y=>nx2112, A=>nx3799);
   ix3824 : inv01 port map ( Y=>nx3823, A=>nx2020);
   ix1981 : inv01 port map ( Y=>nx1980, A=>nx3991);
   ix1949 : inv01 port map ( Y=>nx1948, A=>nx4061);
   ix3792 : inv01 port map ( Y=>nx3791, A=>nx1910);
   ix1869 : inv01 port map ( Y=>nx1868, A=>nx3863);
   ix1761 : inv01 port map ( Y=>nx1760, A=>nx3841);
   ix4070 : inv01 port map ( Y=>nx4069, A=>nx1728);
   ix1269 : inv01 port map ( Y=>nx1268, A=>nx3701);
   ix1265 : inv01 port map ( Y=>nx1264, A=>nx3489);
   ix1261 : inv01 port map ( Y=>nx1260, A=>nx3707);
   ix3616 : inv01 port map ( Y=>nx3615, A=>nx1168);
   ix1129 : inv01 port map ( Y=>nx1128, A=>nx3515);
   ix1097 : inv01 port map ( Y=>nx1096, A=>nx3623);
   ix1017 : inv01 port map ( Y=>nx1016, A=>nx3389);
   ix909 : inv01 port map ( Y=>nx908, A=>nx3357);
   ix3604 : inv01 port map ( Y=>nx3603, A=>nx876);
   ix499 : inv01 port map ( Y=>nx498, A=>nx4888);
   ix495 : inv01 port map ( Y=>nx494, A=>nx4771);
   ix491 : inv01 port map ( Y=>nx490, A=>nx4627);
   ix4643 : inv01 port map ( Y=>nx4642, A=>nx398);
   ix359 : inv01 port map ( Y=>nx358, A=>nx4786);
   ix327 : inv01 port map ( Y=>nx326, A=>nx4837);
   ix4620 : inv01 port map ( Y=>nx4619, A=>nx288);
   ix247 : inv01 port map ( Y=>nx246, A=>nx4681);
   ix139 : inv01 port map ( Y=>nx138, A=>nx4659);
   ix4844 : inv01 port map ( Y=>nx4843, A=>nx106);
   ix5219 : inv01 port map ( Y=>nx5220, A=>nx4847);
   ix5223 : inv01 port map ( Y=>nx5224, A=>derivative_state);
   ix5225 : inv01 port map ( Y=>nx5226, A=>nx5369);
   ix5243 : inv01 port map ( Y=>nx5244, A=>nx3735);
   ix5247 : inv01 port map ( Y=>nx5248, A=>nx4073);
   ix5255 : inv01 port map ( Y=>nx5256, A=>nx3317);
   ix5263 : inv01 port map ( Y=>nx5264, A=>nx4579);
   ix5265 : inv01 port map ( Y=>nx5266, A=>nx5302);
   ix5267 : buf02 port map ( Y=>nx5268, A=>nx4032);
   ix5269 : buf02 port map ( Y=>nx5270, A=>nx4032);
   ix5273 : buf02 port map ( Y=>nx5274, A=>nx4046);
   ix5275 : buf02 port map ( Y=>nx5276, A=>nx4046);
   ix5277 : inv01 port map ( Y=>nx5278, A=>nx5038);
   ix5279 : inv01 port map ( Y=>nx5280, A=>nx5038);
   ix5281 : inv01 port map ( Y=>nx5282, A=>nx5038);
   ix5283 : inv01 port map ( Y=>nx5284, A=>nx5038);
   ix5285 : inv01 port map ( Y=>nx5286, A=>i_valid);
   ix5289 : inv01 port map ( Y=>nx5290, A=>nx5327);
   ix5293 : inv01 port map ( Y=>nx5294, A=>nx3696);
   ix5295 : inv01 port map ( Y=>nx5296, A=>nx3696);
   ix5297 : inv01 port map ( Y=>nx5298, A=>nx3696);
   ix5299 : inv01 port map ( Y=>nx5300, A=>nx4024);
   ix5301 : inv01 port map ( Y=>nx5302, A=>nx5331);
   ix5303 : inv01 port map ( Y=>nx5304, A=>nx5383);
   ix3 : and02 port map ( Y=>nx2, A0=>i_valid, A1=>nx5369);
   ix4665 : nor02ii port map ( Y=>nx4664, A0=>state_1, A1=>nx2885);
   ix2838 : mux21_ni port map ( Y=>nx2837, A0=>w_dbusy, A1=>i_valid, S0=>
      nx4634);
   ix4635 : nor02ii port map ( Y=>nx4634, A0=>i_reset, A1=>nx5369);
   ix2896 : mux21 port map ( Y=>nx2895, A0=>nx2887, A1=>state_1, S0=>nx2885
   );
   ix4659 : xnor2 port map ( Y=>nx4658, A0=>nx2887, A1=>nx2885);
   ix4431 : and04 port map ( Y=>nx4430, A0=>nx3177, A1=>nx3217, A2=>nx3227, 
      A3=>nx5310);
   ix2748 : mux21 port map ( Y=>nx2747, A0=>nx3177, A1=>nx2919, S0=>nx5369);
   ix2962 : nor02ii port map ( Y=>nx2961, A0=>i_pixel_bot(0), A1=>
      i_pixel_top(16));
   ix2885 : and03 port map ( Y=>nx3291, A0=>nx2947, A1=>i_pixel_bot(16), A2
      =>nx2672);
   ix3090 : or02 port map ( Y=>nx2672, A0=>i_pixel_bot(0), A1=>nx2949);
   ix2728 : mux21 port map ( Y=>nx2727, A0=>nx3217, A1=>nx3183, S0=>nx5369);
   ix2738 : mux21 port map ( Y=>nx2737, A0=>nx3227, A1=>nx3223, S0=>nx5369);
   ix3230 : and03 port map ( Y=>nx5310, A0=>nx3239, A1=>nx3247, A2=>nx3256);
   ix2778 : mux21 port map ( Y=>nx2777, A0=>nx3239, A1=>nx3235, S0=>nx5371);
   ix2758 : mux21 port map ( Y=>nx2757, A0=>nx3247, A1=>nx3243, S0=>nx5371);
   ix2768 : mux21 port map ( Y=>nx2767, A0=>nx3256, A1=>nx3253, S0=>nx5371);
   ix4441 : and03 port map ( Y=>nx4440, A0=>nx3267, A1=>nx3275, A2=>nx3295);
   ix2808 : mux21 port map ( Y=>nx2807, A0=>nx3267, A1=>nx3263, S0=>nx5371);
   ix2788 : mux21 port map ( Y=>nx2787, A0=>nx3275, A1=>nx3272, S0=>nx5371);
   ix2798 : mux21 port map ( Y=>nx2797, A0=>nx3295, A1=>nx3279, S0=>nx5371);
   ix2818 : mux21 port map ( Y=>nx2817, A0=>nx3297, A1=>nx3301, S0=>nx5373);
   ix2828 : mux21_ni port map ( Y=>nx2827, A0=>w_D_E_W_0, A1=>nx3340, S0=>
      nx5373);
   ix2718 : mux21 port map ( Y=>nx2717, A0=>nx5335, A1=>nx3320, S0=>nx5373);
   ix4479 : and04 port map ( Y=>nx4478, A0=>nx3587, A1=>nx3627, A2=>nx3637, 
      A3=>nx5312);
   ix2548 : mux21 port map ( Y=>nx2547, A0=>nx3587, A1=>nx3337, S0=>nx5373);
   ix3378 : nor02ii port map ( Y=>nx3377, A0=>i_pixel_mid(0), A1=>
      i_pixel_mid(16));
   ix1059 : and03 port map ( Y=>nx3709, A0=>nx3363, A1=>i_pixel_bot(8), A2=>
      nx846);
   ix3498 : or02 port map ( Y=>nx846, A0=>i_pixel_mid(0), A1=>nx3365);
   ix2578 : mux21 port map ( Y=>nx2577, A0=>nx3627, A1=>nx3593, S0=>nx5373);
   ix2588 : mux21 port map ( Y=>nx2587, A0=>nx3637, A1=>nx3633, S0=>nx5373);
   ix3640 : and03 port map ( Y=>nx5312, A0=>nx3649, A1=>nx3659, A2=>nx3669);
   ix2528 : mux21 port map ( Y=>nx2527, A0=>nx3649, A1=>nx3645, S0=>nx5375);
   ix2558 : mux21 port map ( Y=>nx2557, A0=>nx3659, A1=>nx3655, S0=>nx5375);
   ix2568 : mux21 port map ( Y=>nx2567, A0=>nx3669, A1=>nx3665, S0=>nx5375);
   ix4489 : and03 port map ( Y=>nx4488, A0=>nx3681, A1=>nx3691, A2=>nx3713);
   ix2518 : mux21 port map ( Y=>nx2517, A0=>nx3681, A1=>nx3677, S0=>nx5375);
   ix2538 : mux21 port map ( Y=>nx2537, A0=>nx3691, A1=>nx3687, S0=>nx5375);
   ix2508 : mux21 port map ( Y=>nx2507, A0=>nx3713, A1=>nx3697, S0=>nx5375);
   ix2488 : mux21 port map ( Y=>nx2487, A0=>nx3715, A1=>nx3719, S0=>nx5377);
   ix2498 : mux21_ni port map ( Y=>nx2497, A0=>w_D_NE_SW_0, A1=>nx1366, S0=>
      nx5377);
   ix2478 : mux21 port map ( Y=>nx2477, A0=>nx5341, A1=>nx3739, S0=>nx5377);
   ix4409 : and02 port map ( Y=>nx4408, A0=>nx5038, A1=>nx5353);
   ix4053 : nand02 port map ( Y=>nx5038, A0=>nx5314, A1=>nx5067);
   ix5313 : inv01 port map ( Y=>nx5314, A=>nx3749);
   ix3919 : mux21 port map ( Y=>nx3918, A0=>nx3305, A1=>nx3775, S0=>nx5353);
   ix3776 : mux21_ni port map ( Y=>nx3775, A0=>nx3725, A1=>nx3801, S0=>
      nx5327);
   ix2708 : mux21_ni port map ( Y=>nx2707, A0=>w_D_N_S_0, A1=>nx2366, S0=>
      nx5377);
   ix3796 : or02 port map ( Y=>nx1698, A0=>i_pixel_top(0), A1=>nx3093);
   ix3808 : xnor2 port map ( Y=>nx3807, A0=>nx5347, A1=>nx4085);
   ix2598 : mux21 port map ( Y=>nx2597, A0=>nx5347, A1=>nx3813, S0=>nx5377);
   ix3854 : nor02ii port map ( Y=>nx3853, A0=>i_pixel_top(0), A1=>
      i_pixel_bot(16));
   ix2608 : mux21 port map ( Y=>nx2607, A0=>nx4085, A1=>nx4079, S0=>nx5377);
   ix4090 : xnor2 port map ( Y=>nx4089, A0=>nx5347, A1=>nx4099);
   ix2618 : mux21 port map ( Y=>nx2617, A0=>nx4099, A1=>nx4095, S0=>nx5304);
   ix4104 : xnor2 port map ( Y=>nx4103, A0=>nx5347, A1=>nx4113);
   ix2628 : mux21 port map ( Y=>nx2627, A0=>nx4113, A1=>nx4109, S0=>nx5304);
   ix4118 : xnor2 port map ( Y=>nx4117, A0=>nx5349, A1=>nx4127);
   ix2638 : mux21 port map ( Y=>nx2637, A0=>nx4127, A1=>nx4123, S0=>nx5304);
   ix4132 : xnor2 port map ( Y=>nx4131, A0=>nx5349, A1=>nx4141);
   ix2648 : mux21 port map ( Y=>nx2647, A0=>nx4141, A1=>nx4137, S0=>nx5304);
   ix4146 : xnor2 port map ( Y=>nx4145, A0=>nx5349, A1=>nx4155);
   ix2658 : mux21 port map ( Y=>nx2657, A0=>nx4155, A1=>nx4151, S0=>nx5304);
   ix4160 : xnor2 port map ( Y=>nx4159, A0=>nx5349, A1=>nx4169);
   ix2668 : mux21 port map ( Y=>nx2667, A0=>nx4169, A1=>nx4165, S0=>nx5304);
   ix4174 : xnor2 port map ( Y=>nx4173, A0=>nx5349, A1=>nx4189);
   ix2678 : mux21 port map ( Y=>nx2677, A0=>nx4189, A1=>nx4179, S0=>nx5365);
   ix2379 : and04 port map ( Y=>nx2378, A0=>nx5248, A1=>nx4201, A2=>nx4211, 
      A3=>nx3801);
   ix2688 : mux21 port map ( Y=>nx2687, A0=>nx4201, A1=>nx4197, S0=>nx5365);
   ix2698 : mux21 port map ( Y=>nx2697, A0=>nx4211, A1=>nx4207, S0=>nx5365);
   ix4248 : xnor2 port map ( Y=>nx4247, A0=>nx5349, A1=>nx4211);
   ix2375 : nor02ii port map ( Y=>nx2374, A0=>nx5351, A1=>nx3801);
   ix4260 : xnor2 port map ( Y=>nx4259, A0=>nx5341, A1=>nx3627);
   ix4264 : xnor2 port map ( Y=>nx4263, A0=>nx5341, A1=>nx3637);
   ix4268 : xnor2 port map ( Y=>nx4267, A0=>nx5341, A1=>nx3587);
   ix4272 : xnor2 port map ( Y=>nx4271, A0=>nx5343, A1=>nx3659);
   ix4276 : xnor2 port map ( Y=>nx4275, A0=>nx5343, A1=>nx3669);
   ix4280 : xnor2 port map ( Y=>nx4279, A0=>nx5343, A1=>nx3649);
   ix4284 : xnor2 port map ( Y=>nx4283, A0=>nx5343, A1=>nx3691);
   ix4288 : xnor2 port map ( Y=>nx4287, A0=>nx5343, A1=>nx3713);
   ix1417 : and04 port map ( Y=>nx1416, A0=>nx5244, A1=>nx3681, A2=>nx3715, 
      A3=>nx3725);
   ix4310 : xnor2 port map ( Y=>nx4309, A0=>nx5343, A1=>nx3681);
   ix4324 : xnor2 port map ( Y=>nx4323, A0=>nx5345, A1=>nx3715);
   ix1375 : nor02ii port map ( Y=>nx1374, A0=>nx5345, A1=>nx3725);
   ix4330 : xnor2 port map ( Y=>nx4329, A0=>nx5351, A1=>nx4201);
   ix3693 : mux21_ni port map ( Y=>nx4579, A0=>nx4375, A1=>nx4409, S0=>
      nx4569);
   ix4382 : xnor2 port map ( Y=>nx4381, A0=>nx5335, A1=>nx3227);
   ix4386 : xnor2 port map ( Y=>nx4385, A0=>nx5335, A1=>nx3177);
   ix4390 : xnor2 port map ( Y=>nx4389, A0=>nx5335, A1=>nx3247);
   ix4394 : xnor2 port map ( Y=>nx4393, A0=>nx5337, A1=>nx3256);
   ix4398 : xnor2 port map ( Y=>nx4397, A0=>nx5337, A1=>nx3239);
   ix4402 : xnor2 port map ( Y=>nx4401, A0=>nx5337, A1=>nx3275);
   ix4406 : xnor2 port map ( Y=>nx4405, A0=>nx5337, A1=>nx3295);
   ix3353 : and04 port map ( Y=>nx3352, A0=>nx5256, A1=>nx3267, A2=>nx3297, 
      A3=>nx3305);
   ix4414 : xnor2 port map ( Y=>nx4413, A0=>nx5337, A1=>nx3217);
   ix4448 : xnor2 port map ( Y=>nx4447, A0=>nx5337, A1=>nx3267);
   ix3349 : nor02ii port map ( Y=>nx3348, A0=>nx5339, A1=>nx3305);
   ix2605 : nor02ii port map ( Y=>nx2604, A0=>nx1630, A1=>nx3803);
   ix4502 : xnor2 port map ( Y=>nx4501, A0=>nx5339, A1=>nx3297);
   ix4506 : mux21 port map ( Y=>nx4505, A0=>nx1382, A1=>nx2494, S0=>nx5327);
   ix4512 : mux21 port map ( Y=>nx4511, A0=>nx1482, A1=>nx2484, S0=>nx5327);
   ix4520 : mux21 port map ( Y=>nx4519, A0=>nx1424, A1=>nx2474, S0=>nx5327);
   ix4526 : mux21 port map ( Y=>nx4525, A0=>nx1488, A1=>nx2464, S0=>nx5327);
   ix4534 : mux21 port map ( Y=>nx4533, A0=>nx1476, A1=>nx2454, S0=>nx5329);
   ix4540 : mux21 port map ( Y=>nx4539, A0=>nx1560, A1=>nx2444, S0=>nx5329);
   ix4548 : mux21 port map ( Y=>nx4547, A0=>nx1566, A1=>nx2434, S0=>nx5329);
   ix4554 : mux21 port map ( Y=>nx4553, A0=>nx1554, A1=>nx2424, S0=>nx5329);
   ix4562 : mux21 port map ( Y=>nx4561, A0=>nx1616, A1=>nx2414, S0=>nx5329);
   ix4568 : mux21 port map ( Y=>nx4567, A0=>nx1622, A1=>nx2404, S0=>nx5329);
   ix2458 : mux21_ni port map ( Y=>nx2457, A0=>w_D_NW_SE_0, A1=>nx724, S0=>
      nx5365);
   ix4624 : or02 port map ( Y=>nx76, A0=>nx3501, A1=>i_pixel_top(8));
   ix4632 : xnor2 port map ( Y=>nx4631, A0=>nx5359, A1=>nx4854);
   ix2358 : mux21 port map ( Y=>nx2357, A0=>nx5359, A1=>nx4635, S0=>nx5365);
   ix4672 : nor02ii port map ( Y=>nx4671, A0=>i_pixel_top(8), A1=>
      i_pixel_bot(8));
   ix2448 : mux21 port map ( Y=>nx2447, A0=>nx4854, A1=>nx4851, S0=>nx5365);
   ix733 : nor02ii port map ( Y=>nx732, A0=>nx5359, A1=>nx4607);
   ix3899 : mux21 port map ( Y=>nx3898, A0=>nx4453, A1=>nx4505, S0=>nx5353);
   ix4864 : xnor2 port map ( Y=>nx4863, A0=>nx5359, A1=>nx4870);
   ix2438 : mux21 port map ( Y=>nx2437, A0=>nx4870, A1=>nx4867, S0=>nx5367);
   ix3879 : mux21 port map ( Y=>nx3878, A0=>nx4878, A1=>nx4511, S0=>nx5353);
   ix4882 : xnor2 port map ( Y=>nx4881, A0=>nx5361, A1=>nx4893);
   ix2428 : mux21 port map ( Y=>nx2427, A0=>nx4893, A1=>nx4885, S0=>nx5367);
   ix737 : and04 port map ( Y=>nx736, A0=>nx5220, A1=>nx4870, A2=>nx4854, A3
      =>nx4607);
   ix3859 : mux21 port map ( Y=>nx3858, A0=>nx4441, A1=>nx4519, S0=>nx5353);
   ix4903 : xnor2 port map ( Y=>nx4902, A0=>nx5361, A1=>nx4909);
   ix2418 : mux21 port map ( Y=>nx2417, A0=>nx4909, A1=>nx4906, S0=>nx5367);
   ix3839 : mux21 port map ( Y=>nx3838, A0=>nx4601, A1=>nx4525, S0=>nx5355);
   ix4919 : xnor2 port map ( Y=>nx4918, A0=>nx5361, A1=>nx4925);
   ix2408 : mux21 port map ( Y=>nx2407, A0=>nx4925, A1=>nx4922, S0=>nx5367);
   ix3819 : mux21 port map ( Y=>nx3818, A0=>nx4433, A1=>nx4533, S0=>nx5355);
   ix4935 : xnor2 port map ( Y=>nx4934, A0=>nx5361, A1=>nx4941);
   ix2398 : mux21 port map ( Y=>nx2397, A0=>nx4941, A1=>nx4938, S0=>nx5367);
   ix3799 : mux21 port map ( Y=>nx3798, A0=>nx4595, A1=>nx4539, S0=>nx5355);
   ix4951 : xnor2 port map ( Y=>nx4950, A0=>nx5361, A1=>nx4957);
   ix2388 : mux21 port map ( Y=>nx2387, A0=>nx4957, A1=>nx4954, S0=>nx5367);
   ix3779 : mux21 port map ( Y=>nx3778, A0=>nx4425, A1=>nx4547, S0=>nx5355);
   ix4967 : xnor2 port map ( Y=>nx4966, A0=>nx5361, A1=>nx4973);
   ix2378 : mux21 port map ( Y=>nx2377, A0=>nx4973, A1=>nx4970, S0=>nx5224);
   ix3759 : mux21 port map ( Y=>nx3758, A0=>nx4589, A1=>nx4553, S0=>nx5355);
   ix4983 : xnor2 port map ( Y=>nx4982, A0=>nx5363, A1=>nx4989);
   ix2368 : mux21 port map ( Y=>nx2367, A0=>nx4989, A1=>nx4986, S0=>nx5224);
   ix3739 : mux21 port map ( Y=>nx3738, A0=>nx4417, A1=>nx4561, S0=>nx5355);
   ix4999 : xnor2 port map ( Y=>nx4998, A0=>nx5363, A1=>nx5007);
   ix2468 : mux21 port map ( Y=>nx2467, A0=>nx5007, A1=>nx5002, S0=>nx5224);
   ix3725 : mux21 port map ( Y=>nx3724, A0=>nx4583, A1=>nx4567, S0=>nx5357);
   ix3705 : mux21 port map ( Y=>nx3704, A0=>nx4375, A1=>nx4575, S0=>nx5357);
   ix4531 : and04 port map ( Y=>nx4530, A0=>nx4973, A1=>nx5007, A2=>nx4989, 
      A3=>nx5316);
   ix5028 : and03 port map ( Y=>nx5316, A0=>nx4925, A1=>nx4957, A2=>nx4941);
   ix4541 : and03 port map ( Y=>nx4540, A0=>nx4870, A1=>nx4909, A2=>nx4893);
   ix4579 : and04 port map ( Y=>nx4578, A0=>nx4113, A1=>nx4085, A2=>nx4099, 
      A3=>nx5318);
   ix5035 : and03 port map ( Y=>nx5318, A0=>nx4155, A1=>nx4127, A2=>nx4141);
   ix4589 : and03 port map ( Y=>nx4588, A0=>nx4201, A1=>nx4169, A2=>nx4189);
   ix4047 : and03 port map ( Y=>nx4046, A0=>nx5331, A1=>nx2598, A2=>nx5357);
   ix5088 : nor02ii port map ( Y=>nx4024, A0=>nx3696, A1=>nx3749);
   ix4037 : nor02ii port map ( Y=>nx4036, A0=>nx5357, A1=>nx5331);
   ix4033 : and03 port map ( Y=>nx4032, A0=>nx5333, A1=>nx3803, A2=>nx5357);
   ix4221 : ao21 port map ( Y=>nx4220, A0=>nx3898, A1=>nx5333, B0=>nx3890);
   ix4621 : xor2 port map ( Y=>nx4620, A0=>nx4400, A1=>nx4408);
   ix5251 : nor02ii port map ( Y=>nx5252, A0=>nx1630, A1=>nx3803);
   ix5253 : nor02ii port map ( Y=>nx5254, A0=>nx1630, A1=>nx3803);
   ix5271 : nor02ii port map ( Y=>nx5272, A0=>nx5357, A1=>nx5333);
   eval_lat_w_dir_0_u1 : latchr port map ( QB=>nx5, D=>nx4608, CLK=>nx4610, 
      R=>nx4388);
   eval_lat_w_dir_0_u2 : inv01 port map ( Y=>o_dir(0), A=>nx5);
   eval_lat_w_dir_1_u1 : latchr port map ( QB=>nx5322, D=>nx4408, CLK=>
      nx4610, R=>nx4388);
   eval_lat_w_dir_1_u2 : inv01 port map ( Y=>o_dir(1), A=>nx5322);
   eval_lat_w_dir_2_u1 : latchr port map ( QB=>nx5325, D=>nx4620, CLK=>
      nx4610, R=>nx4388);
   eval_lat_w_dir_2_u2 : inv01 port map ( Y=>o_dir(2), A=>nx5325);
   ix5326 : inv01 port map ( Y=>nx5327, A=>nx3803);
   ix5328 : inv01 port map ( Y=>nx5329, A=>nx3803);
   ix5330 : inv01 port map ( Y=>nx5331, A=>nx5300);
   ix5332 : inv01 port map ( Y=>nx5333, A=>nx5300);
   ix5334 : inv01 port map ( Y=>nx5335, A=>nx5256);
   ix5336 : inv01 port map ( Y=>nx5337, A=>nx5256);
   ix5338 : inv01 port map ( Y=>nx5339, A=>nx5256);
   ix5340 : inv01 port map ( Y=>nx5341, A=>nx5244);
   ix5342 : inv01 port map ( Y=>nx5343, A=>nx5244);
   ix5344 : inv01 port map ( Y=>nx5345, A=>nx5244);
   ix5346 : inv01 port map ( Y=>nx5347, A=>nx5248);
   ix5348 : inv01 port map ( Y=>nx5349, A=>nx5248);
   ix5350 : inv01 port map ( Y=>nx5351, A=>nx5248);
   ix5352 : inv01 port map ( Y=>nx5353, A=>nx5264);
   ix5354 : inv01 port map ( Y=>nx5355, A=>nx5264);
   ix5356 : inv01 port map ( Y=>nx5357, A=>nx5264);
   ix5358 : inv01 port map ( Y=>nx5359, A=>nx5220);
   ix5360 : inv01 port map ( Y=>nx5361, A=>nx5220);
   ix5362 : inv01 port map ( Y=>nx5363, A=>nx5220);
   ix5364 : inv01 port map ( Y=>nx5365, A=>nx5383);
   ix5366 : inv01 port map ( Y=>nx5367, A=>nx5383);
   ix5368 : inv01 port map ( Y=>nx5369, A=>nx5383);
   ix5370 : inv01 port map ( Y=>nx5371, A=>nx5383);
   ix5372 : inv01 port map ( Y=>nx5373, A=>nx5383);
   ix5374 : inv01 port map ( Y=>nx5375, A=>nx5385);
   ix5376 : inv01 port map ( Y=>nx5377, A=>nx5385);
   ix5382 : inv01 port map ( Y=>nx5383, A=>nx5224);
   ix5384 : inv01 port map ( Y=>nx5385, A=>nx5224);
end Structural ;

