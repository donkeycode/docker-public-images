<?php

if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
    $_SERVER['SERVER_PORT']= $_SERVER['HTTP_X_FORWARDED_PORT'] ?? 443;
} else {
    $_SERVER['HTTPS'] = '';
}
