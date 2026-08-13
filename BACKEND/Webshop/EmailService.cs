using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;

namespace Webshop
{
    public class EmailService
    {
        private readonly IConfiguration _config;

        public EmailService(IConfiguration config)
        {
            _config = config;
        }

        public async Task SendEmailAsync(string toEmail, string subject, string body)
        {
            var emailSettings = _config.GetSection("EmailSettings");

            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("Webshop", emailSettings["SenderEmail"]));
            message.To.Add(new MailboxAddress("", toEmail));
            message.Subject = subject;
            message.Body = new TextPart("plain") { Text = body };

            using var client = new SmtpClient();
            await client.ConnectAsync(
                emailSettings["SmtpServer"],
                int.Parse(emailSettings["SmtpPort"]),
                SecureSocketOptions.StartTls);

            await client.AuthenticateAsync(emailSettings["SenderEmail"], emailSettings["SenderPassword"]);
            await client.SendAsync(message);
            await client.DisconnectAsync(true);
        }
    }
}
