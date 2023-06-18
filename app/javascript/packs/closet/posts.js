// ! closet投稿画面、編集画面で大カテゴリーに基づいて小カテゴリーを表示する関数
export function ClosetSelectValue() {
    $('#big-category-select').change(function() {
        var selectedValue = $(this).val();

        $.ajax({
            url: '/realtime_selected_value', // 適切なエンドポイントのURLを設定
            method: 'POST',
            data: { selected_value: selectedValue },
            success: function(response) {
                // // ーバーサイドからのレスポンスを処理
                var smallCategorySelect = $('#small-category-select');
                smallCategorySelect.empty(); // 小カテゴリーセレクトボックスをクリア
                var options = response.options;
                for (var i = 0; i < options.length; i++) {
                    var option = $('<option>').text(options[i]);
                    smallCategorySelect.append(option); // 選択肢を追加
                }
            },
            error: function(error) {
                // エラーハンドリング
                console.log(error);
            },
        });
    });
}