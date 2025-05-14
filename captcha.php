<?php
session_start();

$captcha_text = substr(str_shuffle("ABCDEFGHJKLMNPQRSTUVWXYZ23456789"), 0, 5);
$_SESSION['captcha'] = $captcha_text;

$width = 120;
$height = 40;
$image = imagecreatetruecolor($width, $height);

$bg_color = imagecolorallocate($image, 255, 255, 255);
$text_color = imagecolorallocate($image, 0, 0, 0);
$line_color = imagecolorallocate($image, 150, 150, 150);

imagefilledrectangle($image, 0, 0, $width, $height, $bg_color);

for ($i = 0; $i < 5; $i++) {
    imageline($image, rand(0,$width), rand(0,$height), rand(0,$width), rand(0,$height), $line_color);
}

$font_size = 5;
$text_width = imagefontwidth($font_size) * strlen($captcha_text);
$text_height = imagefontheight($font_size);
$x = ($width - $text_width) / 2;
$y = ($height - $text_height) / 2;

imagestring($image, $font_size, $x, $y, $captcha_text, $text_color);

header("Content-type: image/png");
imagepng($image);
imagedestroy($image);
