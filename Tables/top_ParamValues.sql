CREATE TABLE [dbo].[top_ParamValues]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [IDChain] INT NOT NULL, 
    [pValue] NVARCHAR(4000) NULL, 
    CONSTRAINT [FK_top_ParamValues_top_Chains] FOREIGN KEY (IDChain) REFERENCES [top_Chains]([Id])
)

GO

CREATE INDEX [IX_top_ParamValues_IDChain] ON [dbo].[top_ParamValues] ([IDChain])
