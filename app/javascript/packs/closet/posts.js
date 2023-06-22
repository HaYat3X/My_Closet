// ! closet投稿画面、編集画面で大カテゴリーに基づいて小カテゴリーを表示する関数
export function ClosetSelectValue() {
    $('#big-category-select').change(function() {
        var selectedValue = $(this).val();
        var smallCategorySelect = $('#small-category-select');

        $.ajax({
            url: '/realtime_selected_value', // 適切なエンドポイントのURLを設定
            method: 'POST',
            data: { selected_value: selectedValue },
            success: function(response) {
                smallCategorySelect.empty(); // 小カテゴリーセレクトボックスをクリア
                var options = response.options;
                if (options) {
                    for (var i = 0; i < options.length; i++) {
                        var option = $('<option>').text(options[i]);
                        smallCategorySelect.append(option); // 選択肢を追加
                    }
                } else {
                    // デフォルトの値を追加する
                    var default_options = [
                        'ジャケット',
                        'コート',
                        'ピーコート',
                        'ダウンジャケット',
                        'レザージャケット',
                        'ウインドブレーカー',
                        'カーディガン',
                        'Tシャツ',
                        'シャツ',
                        'ブラウス',
                        'ポロシャツ',
                        'ニットセーター',
                        'パーカー',
                        'ジーンズ',
                        'パンツ',
                        'ショートパンツ',
                        'スカート',
                        'レギンス',
                        'ショーツ',
                        'スカート',
                        'スニーカー',
                        'パンプス',
                        'サンダル',
                        'ブーツ',
                        'フラットシューズ',
                        '革靴',
                        'ネックレス',
                        'ブレスレット',
                        'ピアス',
                        'リング',
                        'ヘアアクセサリー',
                        'その他',
                    ];
                    for (var i = 0; i < default_options.length; i++) {
                        var option = $('<option>').text(default_options[i]);
                        smallCategorySelect.append(option); // 選択肢を追加
                    }
                }
            },

            error: function(error) {
                // エラーハンドリング
                console.log(error);
            },
        });
    });
}