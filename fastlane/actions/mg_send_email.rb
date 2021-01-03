#!/usr/bin/ruby -w
# -*- coding: UTF-8 -*-

require 'net/smtp'

module Fastlane
  module Actions
    module SharedValues
      SEND_MAIL_CUSTOM_VALUE = :SEND_MAIL_CUSTOM_VALUE
    end

    class MgSendEmailAction < Action

       def self.send_emails(stmpserver_address,sender_address,password,recipients,subject,message_body)

            # 遍历数组

            recipients_json = ''
            recipients.each { |recipient_address| 
             recipients_json=recipients_json+recipient_address+"," 
           }

            puts("#{recipients_json}")


            message_header = ''
            message_header << "From: <#{sender_address}>\r\n"
            # message_header << "To: " + "<" + recipients.to_s + ">\r\n"
            message_header << "To: <#{recipients_json}>\r\n"
            message_header << "Subject: #{subject}\r\n"
            message_header << 'Date: ' + Time.now.to_s + "\r\n"
            message_header << 'MIME-Version: 1.0' + "\r\n"
            message_header << 'Content-type: text/html;charset=utf-8' + "\r\n"
            message_header << 'X-Priority:3;X-MSMail-Priority:Normal;X-Mailer:Microsoft Outlook Express 6.00.2900.2869;X-MimeOLE:Produced By Microsoft MimeOLE V6.00.2900.2869;ReturnReceipt:1' + "\r\n"
            message = message_header + "\r\n" + message_body.encode('utf-8') + "\r\n"

            puts("--------------------------------------------------")
            puts("👉 发送人: #{sender_address}")
            puts("👉 接收者: #{recipients}")
            puts("👉 #{message}")
            puts("--------------------------------------------------")

          begin 
              Net::SMTP.start(stmpserver_address, 25, 'yeah.net', sender_address, password, :plain) do |smtp|
              smtp.sendmail(message, sender_address, recipients)

              UI.success("👉 邮件发送成功啦！！！🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀")
            end

            rescue Exception => e  
                  print "Exception occured: " + e  
            end
        end

      def self.run(params)
         send_emails(
                    params[:stmp_server],
                    params[:user_name],
                    params[:password],
                    params[:recipients],
                    params[:subject],
                    params[:message_body]
                  )
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :stmp_server,
                                      description: '服务器地址',
                                      optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :user_name,
                                      description: '用户名',
                                      optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :password,
                                      description: '密码',
                                      optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :recipients,
                                      description: '收件人',
                                      optional: false,
                                      type: Array),
          FastlaneCore::ConfigItem.new(key: :subject,
                                      description: '邮件主题(标题)',
                                      optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :message_body,
                                      description: '邮件内容',
                                      optional: true,
                                      type: String)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['SEND_MAIL_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["maling"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
