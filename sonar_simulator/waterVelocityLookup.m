function [ velocity ] = waterVelocityLookup( temperature )
%WATERVELOCITYLOOKUP Returns speed of sound in water in ft/s for a given water
%temperature in F

temperature_lookup = [32;40;50;60;70;80;90;100;120;140;160;180;200;212];
velocity_lookup = [4603;4672;4748;4814;4871;4919;4960;4995;5049;5091; 5101; 5095; 5089; 5062];


temperature_comp = abs(temperature_lookup - temperature);

[~, match_index] = min(temperature_comp);

velocity = velocity_lookup(match_index);


end

