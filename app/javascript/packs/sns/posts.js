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

// export function ItemReload() {
//   // ボタンのクリックイベントを監視
//   document.getElementById("myButton").addEventListener("click", function() {
//     var items = "コメント";

//     $.ajax({
//         url: "/realtime_reload_items", // コントローラーのアクションのURLを指定
//         method: "POST", // リクエストメソッドを指定
//         data: { reload_items: items },
//         dataType: "text", // 必要な場合はデータ型を指定
//         success: function(items) {
//             // レスポンスを受け取った後の処理
//             console.log(items);
//         },
//         error: function(xhr, status, error) {
//             // エラーハンドリング
//             console.log(error);
//             console.log("ミスってます");
//         }
//         });
//     });
// }

export function ItemReload(){
    var items = "コメント";
    // ボタンのクリックイベントを監視
    document.getElementById("myButton").addEventListener("click", function() {
    $.ajax({
        url: "/realtime_reload_items/:items", // コントローラーのアクションのURLを指定
        method: "POST", // リクエストメソッドを指定
        data: { reload_items: items },
        dataType: "text", // 必要な場合はデータを指定
        success: function() {
        // レスポンスを受け取った後の処理
        console.log(items);

        },
        error: function(error) {
        // エラーハンドリング
        console.log(error);
        // isLoading = false; // リクエストが完了したことをフラグで示す
        console.log("ミスってます");
        }
    });
    });
}