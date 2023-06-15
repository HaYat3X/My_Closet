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




// // ! SNS機能でAjaxサーバーを使って使って取得したいアイテム数を増やす
// export function SnsSelect() {
//     $('#big-category-select').change(function() {
//         var selectedValue = $(this).val();

//         $.ajax({
//             url: '/realtime_selected_value', // 適切なエンドポイントのURLを設定
//             method: 'POST',
//             data: { selected_value: selectedValue },
//             success: function(response) {
//                 // // ーバーサイドからのレスポンスを処理
//                 var smallCategorySelect = $('#small-category-select');
//                 smallCategorySelect.empty(); // 小カテゴリーセレクトボックスをクリア
//                 var options = response.options;
//                 for (var i = 0; i < options.length; i++) {
//                     var option = $('<option>').text(options[i]);
//                     smallCategorySelect.append(option); // 選択肢を追加
//                 }
//             },
//             error: function(error) {
//                 // エラーハンドリング
//                 console.log(error);
//             },
//         });
//     });
// }