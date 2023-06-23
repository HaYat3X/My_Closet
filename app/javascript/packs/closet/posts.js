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

export function ClosetBrandValue() {
    $(document).ready(function() {
        $('input[name="brand_search"]').on('input', function() {
            var searchQuery = $(this).val(); // 検索クエリを取得

            // 検索結果を表示する領域
            var brand_select = $('#brand-select');

            // Ajaxリクエストを送信
            $.ajax({
                url: '/brand_search',
                method: 'GET',
                data: { search: searchQuery },
                success: function(response) {
                    brand_select.empty();
                    var options = response.options;

                    if (!options.includes(searchQuery)) {
                        options.push(searchQuery);
                    }

                    for (var i = 0; i < options.length; i++) {
                        var option = $('<option>').text(options[i]);
                        brand_select.append(option);
                    }
                },
                error: function(error) {
                    console.log(error);
                },
            });
        });
    });
}