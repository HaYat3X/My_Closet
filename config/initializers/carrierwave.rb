# ! 本番環境時の画像アップロードの設定
CarrierWave.configure do |config|
  # * クライアントの設定
  config.fog_credentials = {
    # ? プロバイダーの設定
    provider: 'AWS',

    # ? アクセスキーの設定
    aws_access_key_id: ENV['AWS_ACCESS_KEY'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],

    # ? 謎 （すみません）
    use_iam_profile:       false,

    # ? バケットのリージョン設定
    region:                'ap-northeast-1',
  }

  # * バケット名
  config.fog_directory = ENV['S3_BUCKET']
  config.fog_public = false
end