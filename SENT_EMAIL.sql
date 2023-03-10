CREATE PROCEDURE sp_SendPolicyStatusReport
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusReport NVARCHAR(MAX);
    DECLARE @recipientEmail NVARCHAR(100) = 'quandoong@gmail.com';
    DECLARE @senderEmail NVARCHAR(100) = 'dongvanquan0201@gmail.com';
    DECLARE @subject NVARCHAR(200) = 'Policy Status Report';
    DECLARE @body NVARCHAR(MAX) = 'Please find attached the latest policy status report.';

    -- Check if there are any records with status other than "Active"
    IF EXISTS (
        SELECT *
        FROM (
            SELECT LOP.policy_title,
            CASE
                WHEN TEST.is_enabled = 1 THEN 'Active'
                WHEN TEST.is_enabled = 0 THEN 'Inactive'
                WHEN TEST.is_enabled IS NULL THEN 'Deleted'
            END AS Status
            FROM Behaviour.dbo.List_Of_Policy LOP 
            LEFT JOIN Behaviour.dbo.Test_Security TEST ON LOP.policy_title = TEST.policy_title
        ) AS Result
        WHERE Status <> 'Active'
    )
    BEGIN
        -- Generate the status report

        SELECT @statusReport = (
            SELECT *
            FROM (
                SELECT LOP.policy_title,
                CASE
                    WHEN TEST.is_enabled = 1 THEN 'Active'
                    WHEN TEST.is_enabled = 0 THEN 'Inactive'
                    WHEN TEST.is_enabled IS NULL THEN 'Deleted'
                END AS Status
                FROM Behaviour.dbo.List_Of_Policy LOP 
                LEFT JOIN Behaviour.dbo.Test_Security TEST ON LOP.policy_title = TEST.policy_title
            ) AS Result
            WHERE Status <> 'Active'
            FOR XML PATH('table'), ELEMENTS XSINIL, TYPE
        ).value('(/table)[1]', 'NVARCHAR(MAX)');

        -- Send the email
        EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'dongvanquan',
            @recipients = @recipientEmail,
            @from_address = @senderEmail,
            @subject = @subject,
            @body = @body,
            @body_format = 'HTML',
            @query = 'SELECT ' + QUOTENAME(''''+@statusReport+''''),
            @attach_query_result_as_file = 1,
            @query_attachment_filename = 'PolicyStatusReport.xml',
            @query_result_separator = CHAR(9),
            @query_result_no_padding = 1;
    END
END



ALTER PROCEDURE sp_SendPolicyStatusReport
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusReport NVARCHAR(MAX);
    DECLARE @recipientEmail NVARCHAR(100) = 'quandoong@gmail.com';
    DECLARE @senderEmail NVARCHAR(100) = 'dongvanquan0201@gmail.com';
    DECLARE @subject NVARCHAR(200) = 'Policy Status Report';
    DECLARE @body NVARCHAR(MAX) = 'Please find attached the latest policy status report.';

    -- Check if there are any records with status other than "Active"
    IF EXISTS (
        SELECT *
        FROM (
            SELECT LOP.policy_title,
            CASE
                WHEN TEST.is_enabled = 1 THEN 'Active'
                WHEN TEST.is_enabled = 0 THEN 'Inactive'
                WHEN TEST.is_enabled IS NULL THEN 'Deleted'
            END AS Status
            FROM Behaviour.dbo.List_Of_Policy LOP 
            LEFT JOIN Behaviour.dbo.Test_Security TEST ON LOP.policy_title = TEST.policy_title
        ) AS Result
        WHERE Status <> 'Active'
    )
    BEGIN
        -- Generate the status report
        SET @statusReport = (
            SELECT * FROM(
                SELECT LOP.policy_title AS 'td',
                    CASE
                        WHEN TEST.is_enabled = 1 THEN 'Active'
                        WHEN TEST.is_enabled = 0 THEN 'Inactive'
                        WHEN TEST.is_enabled IS NULL THEN 'Deleted'
                    END AS 'td'
                FROM Behaviour.dbo.List_Of_Policy LOP 
                LEFT JOIN Behaviour.dbo.Test_Security TEST ON LOP.policy_title = TEST.policy_title) as Result
                WHERE Status <> 'Active'
                FOR XML PATH('tr'), ELEMENTS XSINIL, TYPE
            ).value('.', 'NVARCHAR(MAX)') AS 'table';

        -- Send the email
        EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'dongvanquan',
            @recipients = @recipientEmail,
            @from_address = @senderEmail,
            @subject = @subject,
            @body = @body,
            @body_format = 'HTML',
            @query = 'SELECT ' + QUOTENAME(@statusReport),
            @attach_query_result_as_file = 1,
            @query_attachment_filename = 'PolicyStatusReport.html';
    END
END



ALTER PROCEDURE sp_SendPolicyStatusReport
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusReport NVARCHAR(MAX);
    DECLARE @recipientEmail NVARCHAR(100) = 'quandoong@gmail.com';
    DECLARE @senderEmail NVARCHAR(100) = 'dongvanquan0201@gmail.com';
    DECLARE @subject NVARCHAR(200) = 'Policy Status Report';
    DECLARE @body NVARCHAR(MAX) = 'Please find attached the latest policy status report.';

    -- Check if there are any records with status other than "Active"
    IF EXISTS (
        SELECT *
        FROM (
            SELECT LOP.policy_title,
            CASE
                WHEN TEST.is_enabled = 1 THEN 'Active'
                WHEN TEST.is_enabled = 0 THEN 'Inactive'
                WHEN TEST.is_enabled IS NULL THEN 'Deleted'
            END AS Status
            FROM Behaviour.dbo.List_Of_Policy LOP 
            LEFT JOIN Behaviour.dbo.Test_Security TEST ON LOP.policy_title = TEST.policy_title
        ) AS Result
        WHERE Status <> 'Active'
    )
    BEGIN
        -- Generate the status report

        SELECT @statusReport = (
            SELECT *
            FROM (
                SELECT LOP.policy_title,
                CASE
                    WHEN TEST.is_enabled = 1 THEN 'Active'
                    WHEN TEST.is_enabled = 0 THEN 'Inactive'
                    WHEN TEST.is_enabled IS NULL THEN 'Deleted'
                END AS Status
                FROM Behaviour.dbo.List_Of_Policy LOP 
                LEFT JOIN Behaviour.dbo.Test_Security TEST ON LOP.policy_title = TEST.policy_title
            ) AS Result
            WHERE Status <> 'Active'
            FOR XML PATH('table'), ELEMENTS XSINIL, TYPE
        ).value('(/table)[1]', 'NVARCHAR(MAX)');

        -- Format the status report as an HTML table
        SET @statusReport = '<html><body><table border="1">' + 
                            '<tr><th>Policy Title</th><th>Status</th></tr>' +
                            @statusReport +
                            '</table></body></html>';

        -- Send the email
        EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'dongvanquan',
            @recipients = @recipientEmail,
            @from_address = @senderEmail,
            @subject = @subject,
            @body = @statusReport,
            @body_format = 'HTML',
            @query_attachment_filename = 'PolicyStatusReport.xml',
            @query_result_separator = VARCHAR(9),
            @query_result_no_padding = 1;
    END
END


EXEC sp_SendPolicyStatusReport







ALTER PROCEDURE sp_SendPolicyStatusReport
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @recipientEmail NVARCHAR(100) = 'quandoong@gmail.com';
    DECLARE @senderEmail NVARCHAR(100) = 'dongvanquan0201@gmail.com';
    DECLARE @subject NVARCHAR(200) = 'Policy Status Report';
    DECLARE @body NVARCHAR(MAX) = 'Please find attached the latest policy status report.';

    IF EXISTS (
        SELECT *
        FROM (
            SELECT LOP.policy_title,
            CASE
                WHEN TEST.is_enabled = 1 THEN 'Active'
                WHEN TEST.is_enabled = 0 THEN 'Inactive'
                WHEN TEST.is_enabled IS NULL THEN 'Deleted'
            END AS Status
            FROM Behaviour.dbo.List_Of_Policy LOP 
            LEFT JOIN Behaviour.dbo.Test_Security TEST ON LOP.policy_title = TEST.policy_title
        ) AS Result
        WHERE Status <> 'Active'
    )
    BEGIN
	DECLARE @statusReport NVARCHAR(MAX) = '';

	Set @statusReport = CONVERT(NVARCHAR(MAX), (
    SELECT *
        FROM (
            SELECT LOP.policy_title,
            CASE
                WHEN TEST.is_enabled = 1 THEN 'Active'
                WHEN TEST.is_enabled = 0 THEN 'Inactive'
                WHEN TEST.is_enabled IS NULL THEN 'Deleted'
            END AS Status
            FROM Behaviour.dbo.List_Of_Policy LOP 
            LEFT JOIN Behaviour.dbo.Test_Security TEST ON LOP.policy_title = TEST.policy_title
        ) AS Result
        WHERE Status <> 'Active'
    FOR XML PATH('tr'), ELEMENTS XSINIL, TYPE));
--).value('(/tr)[2]', 'NVARCHAR(MAX)');

			--SET @statusReport = '<html><body><table border="1">' + 
              --      '<tr><th>Policy Title</th><th>Status</th></tr>' +
                --    @statusReport +
                  --  '</table></body></html>';

		SET @statusReport = '<html><body><p>Please find the policy status report below:</p>' + @statusReport + '</body></html>';

        EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'dongvanquan',
            @recipients = @recipientEmail,
            @from_address = @senderEmail,
            @subject = @subject,
            @body = @statusReport,
            @body_format = 'HTML',
            @query_attachment_filename = 'PolicyStatusReport.xml',
            @query_result_separator = ',',
            @query_result_no_padding = 1;
    END
END






EXEC sp_SendPolicyStatusReport



select * from msdb.dbo.sysmail_allitems

select * from msdb.dbo.sysmail_event_log;



ALTER PROCEDURE send_email_with_query_result
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @query_result NVARCHAR(MAX);
    DECLARE @mail_body NVARCHAR(MAX);
    DECLARE @query_params NVARCHAR(500) ;
    DECLARE @query_result_header NVARCHAR(MAX);
    DECLARE @mail_subject NVARCHAR(255) = 'HELLOOOO THIS IS THE SUBJECT';
    DECLARE @mail_recipients VARCHAR(MAX) = 'quandoong@gmail.com';
    DECLARE @mail_attachments VARCHAR(MAX) =  COALESCE(@attachment_filename, 'QueryResults.csv');
    DECLARE @mail_body_format NVARCHAR(20) = 'HTML';
    DECLARE @mail_priority INT = 1;
    DECLARE @attachment_filename NVARCHAR(255) = 'query_result.csv';
    DECLARE @query_text NVARCHAR(MAX) = 'SELECT * FROM Behaviour.dbo.Test_Security';

    -- Execute the query and store the result in a variable
    EXEC sp_executesql @query_text, N'@query_result NVARCHAR(MAX) OUTPUT', @query_result = @query_result OUTPUT;

    -- Generate the header for the query result table
    SET @query_result_header = '<table><tr>';
    SELECT @query_result_header = @query_result_header + '<th>' + name + '</th>' FROM tempdb.sys.columns WHERE object_id = OBJECT_ID('tempdb..#temp_table');
    SET @query_result_header = @query_result_header + '</tr>';

    -- Generate the body of the email
    SET @mail_body = @query_result_header + CAST((SELECT CAST(@query_result AS XML) AS QueryResult FOR XML PATH('tr'), TYPE) AS NVARCHAR(MAX)) + '</table>';

    -- Send the email
    EXEC msdb.dbo.sp_send_dbmail
        @recipients = @mail_recipients,
        @subject = @mail_subject,
        @body = @mail_body,
        @body_format = @mail_body_format,
        @file_attachments = @attachment_filename,
        @query_result_header = 0,
        @query_no_truncate = 1,
        @query_result_separator = ',',
        @query_result_width = 32767,
		@query = 'SELECT * FROM Behaviour.dbo.Test_Security',
        @query_result_max_characters = 2147483647,
        @query_params = @query_params,
        @attach_query_result_as_file = 1,
        @query_attachment_filename = 'csv.csv',
        @priority = @mail_priority;

END



EXEC send_email_with_query_result


SELECT * FROM msdb.dbo.sysmail_allitems