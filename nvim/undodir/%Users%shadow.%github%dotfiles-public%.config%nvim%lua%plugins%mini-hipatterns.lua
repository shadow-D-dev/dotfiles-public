Vim�UnDo� ��&���Mtx�⍽��Gs�H�v�kh�$���      	},                             g͠    _�                             ����                                                                                                                                                                                                                                                                                                                                                             g͠     �                   �               5��                                         v      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             g͠     �               	{5��                                               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             g͠     �                 	},5��                         {                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             g͠    �                      	return{    		"echasnovski/mini.hipatterns",   		event = "BufReadPre",   
		opts = {   			highlighters = {   				hsl_color = {   .					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",   					group = function(_, match)   2						local utils = require("solarized-osaka.hsl")   &						--- @type string, string, string   J						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")   )						--- @type number?, number?, number?   >						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)   						--- @type string   /						local hex_color = utils.hslToHex(h, s, l)   D						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")   						end,   				},   			},   		},   	}5��                                 z      �      5��