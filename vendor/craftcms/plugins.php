<?php

$vendorDir = dirname(__DIR__);
$rootDir = dirname(dirname(__DIR__));

return array (
  'craftcms/element-api' => 
  array (
    'class' => 'craft\\elementapi\\Plugin',
    'basePath' => $vendorDir . '/craftcms/element-api/src',
    'handle' => 'element-api',
    'aliases' => 
    array (
      '@craft/elementapi' => $vendorDir . '/craftcms/element-api/src',
    ),
    'name' => 'Element API',
    'version' => '2.6.0',
    'description' => 'Create a JSON API for your elements in Craft',
    'developer' => 'Pixel & Tonic',
    'developerUrl' => 'https://pixelandtonic.com/',
    'developerEmail' => 'support@craftcms.com',
    'documentationUrl' => 'https://github.com/craftcms/element-api/blob/v2/README.md',
  ),
  'craftcms/redactor' => 
  array (
    'class' => 'craft\\redactor\\Plugin',
    'basePath' => $vendorDir . '/craftcms/redactor/src',
    'handle' => 'redactor',
    'aliases' => 
    array (
      '@craft/redactor' => $vendorDir . '/craftcms/redactor/src',
    ),
    'name' => 'Redactor',
    'version' => '2.6.1',
    'description' => 'Edit rich text content in Craft CMS using Redactor by Imperavi.',
    'developer' => 'Pixel & Tonic',
    'developerUrl' => 'https://pixelandtonic.com/',
    'developerEmail' => 'support@craftcms.com',
    'documentationUrl' => 'https://github.com/craftcms/redactor/blob/v2/README.md',
  ),
  'chasegiunta/scss' => 
  array (
    'class' => 'chasegiunta\\scss\\Scss',
    'basePath' => $vendorDir . '/chasegiunta/scss/src',
    'handle' => 'scss',
    'aliases' => 
    array (
      '@chasegiunta/scss' => $vendorDir . '/chasegiunta/scss/src',
    ),
    'name' => 'SCSS',
    'version' => '1.0.0',
    'description' => 'Compiler for SCSS',
    'developer' => 'Chase Giunta',
    'developerUrl' => 'https://chasegiunta.com',
    'changelogUrl' => 'https://raw.githubusercontent.com/chasegiunta/scss/master/CHANGELOG.md',
    'hasCpSettings' => false,
    'hasCpSection' => false,
    'components' => 
    array (
      'scssService' => 'chasegiunta\\scss\\services\\ScssService',
    ),
  ),
  'mmikkel/cp-field-inspect' => 
  array (
    'class' => 'mmikkel\\cpfieldinspect\\CpFieldInspect',
    'basePath' => $vendorDir . '/mmikkel/cp-field-inspect/src',
    'handle' => 'cp-field-inspect',
    'aliases' => 
    array (
      '@mmikkel/cpfieldinspect' => $vendorDir . '/mmikkel/cp-field-inspect/src',
    ),
    'name' => 'CP Field Inspect',
    'version' => '1.1.3',
    'schemaVersion' => '1.0.0',
    'description' => 'Inspect field handles and easily edit field and element source settings',
    'developer' => 'Mats Mikkel Rummelhoff',
    'developerUrl' => 'http://mmikkel.no',
    'changelogUrl' => 'https://raw.githubusercontent.com/mmikkel/CpFieldInspect-Craft/master/CHANGELOG.md',
    'hasCpSettings' => false,
    'hasCpSection' => false,
  ),
  'nystudio107/craft-cookies' => 
  array (
    'class' => 'nystudio107\\cookies\\Cookies',
    'basePath' => $vendorDir . '/nystudio107/craft-cookies/src',
    'handle' => 'cookies',
    'aliases' => 
    array (
      '@nystudio107/cookies' => $vendorDir . '/nystudio107/craft-cookies/src',
    ),
    'name' => 'Cookies',
    'version' => '1.1.12',
    'schemaVersion' => '1.0.0',
    'description' => 'A simple plugin for setting and getting cookies from within Craft CMS templates.',
    'developer' => 'nystudio107',
    'developerUrl' => 'https://nystudio107.com/',
    'changelogUrl' => 'https://raw.githubusercontent.com/nystudio107/craft-cookies/v1/CHANGELOG.md',
    'hasCpSettings' => false,
    'hasCpSection' => false,
    'components' => 
    array (
      'cookies' => 'nystudio107\\cookies\\services\\CookiesService',
    ),
  ),
);
