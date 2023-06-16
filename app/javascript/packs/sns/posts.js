// ! SNS投稿画面、SNS編集画面でアイテムを選択数や選択上限を制御
export function ItemSelect() {
    var maxSelection = 6; // 最大選択数
    var checkboxes = $('.checkbox-image');

    checkboxes.change(function() {
        var selectedCount = checkboxes.filter(':checked').length;
        var image = $(this).prev('.checkbox-image-label').find('img');

        if ($(this).is(':checked')) {
            image.addClass('selected-image');
        } else {
            image.removeClass('selected-image');
        }

        if (selectedCount > maxSelection) {
            $(this).prop('checked', false);
            image.removeClass('selected-image');
            alert('アイテムの最大選択数は6件までです。');
        }
    });
}