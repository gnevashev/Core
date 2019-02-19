:setvar XMLDATA "'"

DECLARE @json_t_CoreTable2 nvarchar(max) = 
$(XMLDATA)
:r ..\Data\t_CoreTable2.json
$(XMLDATA)


--set identity_insert t_CoreTable2 on
merge into [dbo].t_CoreTable2 as tc
  using (
	select Id
	from openjson (@json_t_CoreTable2)  
	with (   
			Id int '$.Id'
)) s (Id) ON s.Id = tc.Id
--when matched then update set TypeOper = s.TypeOper, Caption = s.Caption

when not matched by target
then insert (Id)
values (Id)

when not matched by source then delete;
--set identity_insert t_CoreTable2 off