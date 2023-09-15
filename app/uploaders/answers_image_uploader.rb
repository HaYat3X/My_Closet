class AnswersImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    # * 本番環境とローカル環境でアップロードする環境を分ける
    if Rails.env.production?
        # ? S3
        storage :fog
    else
        # ? LOCAL
        storage :file
    end

    process :optimize_image

	def optimize_image
		manipulate! do |img|
			img.strip
			img.resize '500x500>'
		end
	end

    def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    version :forced_size do
        process resize_to_fill: [300, 400]
    end

    def extension_allowlist
        %w(jpg jpeg png)
    end
end
