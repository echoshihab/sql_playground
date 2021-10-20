
/******DML(Data Manipulation Language) Trigger Demo*****/

/******Script Date: 2021-10-20 8:15:51 AM ******/



/* Create student table  */
CREATE TABLE [dbo].[tblStudent](
    [StudentId] [int] NOT NULL PRIMARY KEY,
	[StudentName] [varchar](40) NOT NULL,
) 
GO


/*Create Audit Table */
CREATE TABLE [dbo].[tblStudentAudit](
	[Id] [int] NOT NULL IDENTITY PRIMARY KEY,
	[Event] [varchar](120) NOT NULL
)
GO

/*Create After Trigger for Insert Student */
CREATE TRIGGER [dbo].[tr_tblStudent_AuditInsert]
on [tblStudent]
FOR INSERT
AS
BEGIN
	DECLARE @StudentId int
	SELECT @StudentId = StudentId FROM inserted 
	
	INSERT INTO tblStudentAudit
	VALUES('New Student with StudentId of = ' + 
	CAST(@StudentId as nvarchar(10)) +
	' is added at ' + 
	CONVERT(nvarchar, GETDATE(), 1)
	)
END
GO

/**Test**/
INSERT INTO [dbo].[tblStudent]
VALUES(1, 'Michael Jordan');
GO

/**View Result of trigger **/
SELECT * FROM tblStudentAudit;
GO