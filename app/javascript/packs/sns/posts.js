// ! SNS投稿画面、SNS編集画面でアイテムを選択数や選択上限を制御
export function ItemSelect() {
    var maxSelection = 6; // 最大選択数
    var checkboxes = $('.checkbox-image');
    var selectedImages = []; // 選択された画像の配列
    var markCounter = 1; // マークのカウンター

    var messageContainer = $('#messageContainer');

    checkboxes.change(function() {
        var selectedCount = checkboxes.filter(':checked').length;
        var image = $(this).prev('.checkbox-image-label').find('img');
        var label = $(this).prev('.checkbox-image-label');

        if ($(this).is(':checked')) {
            // 画像が選択された場合
            if (selectedCount <= maxSelection) {
                // 選択数が最大選択数以下の場合
                var mark = $('<span class="image-mark">' + markCounter + '</span>');
                markCounter++;
                selectedImages.push({
                    image: image,
                    mark: mark
                });
                image.addClass('selected-image');
                label.append(mark).css('position', 'relative');
            } else {
                // 選択数が最大選択数を超えた場合
                $(this).prop('checked', false);
                showMessage('アイテムの最大選択数は6件までです。');
            }
        } else {
            // 画像が選択解除された場合
            var index = selectedImages.findIndex(function(item) {
                return item.image.is(image);
            });
            if (index > -1) {
                // 選択された画像が配列内に存在する場合
                var removedItem = selectedImages.splice(index, 1)[0];
                removedItem.image.removeClass('selected-image');
                removedItem.mark.remove();
            }

            // マークの再配置
            selectedImages.forEach(function(item, index) {
                item.mark.text(index + 1);
            });

            markCounter--;
        }

        if (selectedCount <= maxSelection) {
            hideMessage();
        }
    });

    function showMessage(message) {
        messageContainer.text(message).show();
    }

    function hideMessage() {
        messageContainer.hide();
    }
    // // 特定のIDのチェックボックスを選択状態にする
    function selectCheckboxById(id) {
        var checkbox = $('#' + id);
        checkbox.prop('checked', true).trigger('change');
    }
}