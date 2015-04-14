(function($) {
    $.fn.columnizeList = function(settings) {

        settings = $.extend($.fn.columnizeList.defaults, settings);

        // if (!columnCountSupported()) {
        if (true) {
            return this.each(function() {
                var $list = $(this),
                // we create the clone of our list in order to test height/width
                $listClone = $list.clone(),
                $items = $list.children('li'),
                itemsPerCol = Math.ceil($items.length / settings.columnCount),
                columnWidth,
                columnHeight,
                itemHeight = 0,
                widthCounter = 0;

                // hide the clone from the viewport
                $listClone.css({
                    position: 'absolute',
                    left: '-4999px'
                });

                // append the clone to the body, so it has dimensions
                $('body').append($listClone);

                heightCounter = itemHeight = $listClone.find('li').first().outerHeight();
                columnHeight = itemsPerCol * itemHeight;
                columnWidth = Math.floor(100 / settings.columnCount);

                $items.each(function(i) {
                    var $item = $(this);

                    // new column
                    if (i > 0 && i % itemsPerCol == 0) {
                        widthCounter += columnWidth;
                        $item.css('margin-top', -columnHeight);
                    }
                    if (widthCounter > 0) {
                        $item.css('margin-left', widthCounter + '%');
                    }
                });
                
                $listClone.remove();
            });
        }
    };


    $.fn.columnizeList.defaults = {
        columnCount: 2,
        columnGap: 0
    };

})(jQuery);