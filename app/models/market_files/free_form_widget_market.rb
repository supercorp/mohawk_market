module FreeFormWidgetMarket
  THUMBNAIL_SIZES = {:widget_square => '216x247#',
                     :widget_wide_2 => '462x247#',
                     :widget_wide_3 => '708x247#',
                     :widget_wide_4 => '954x247#',
                     :widget_tall => '216'}.merge Widget::THUMBNAIL_SIZES
  IMAGE_SIZE_HELP_TEXT = {'square' => "216px x 247px",
                        'tall' => "216px wide and any height",
                        'wide_2' => "462px x 247px",
                        'wide_3' => "708px x 247px",
                        'wide_4' => "954px x 247px"} 
end
