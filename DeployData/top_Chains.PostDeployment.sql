:setvar XMLDATA "'"

DECLARE @json_top_Chains nvarchar(max) = 
$(XMLDATA)
:r ..\Data\top_Chains.json
$(XMLDATA)


set identity_insert top_Chains on
merge into [dbo].top_Chains as tc
  using (
	select Id, TypeOper, Caption
	from openjson (@json_top_Chains)  
	with (   
				Id int '$.Id'
			, TypeOper int '$.TypeOper'
			, Caption nvarchar (50) '$.Caption'
)) s (Id, TypeOper, Caption) ON s.Id = tc.Id
when matched and (
        s.TypeOper <> tc.TypeOper
        or not ((s.Caption = tc.Caption and not (s.Caption IS NULL OR tc.Caption IS NULL)) OR (s.Caption IS NULL AND tc.Caption IS NULL))
    )
then update set TypeOper = s.TypeOper, Caption = s.Caption

when not matched by target
then insert (Id, TypeOper, Caption)
values (Id, TypeOper, Caption)

when not matched by source then delete;
set identity_insert top_Chains off