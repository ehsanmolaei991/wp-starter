<?php
/**
 * Plugin Name: Custom Plugin
 * Description: افزونه‌ای ساده برای تمرین توسعه پلاگین.
 * Author: Seyed
 * Version: 1.0
 */

// هوک ساده برای نمایش پیغام در فوتر
add_action('wp_footer', function () {
    echo '<p style="text-align: center;">این پیغام از افزونه اختصاصی نمایش داده شده است.</p>';
});
