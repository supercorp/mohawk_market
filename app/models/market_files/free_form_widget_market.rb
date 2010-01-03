module FreeFormWidgetMarket
  THUMBNAIL_SIZES = {:widget_square => '238x238#',
                     :widget_wide_2 => '483x238#',
                     :widget_wide_3 => '729x238#',
                     :widget_wide_4 => '975x238#',
                     :widget_tall => '238'}.merge Widget::THUMBNAIL_SIZES
  IMAGE_SIZE_HELP_TEXT = {'square' => "238px x 238px",
                        'tall' => "238px wide and any height",
                        'wide_2' => "483px x 238px",
                        'wide_3' => "729px x 238px",
                        'wide_4' => "975px x 238px"} 
end
