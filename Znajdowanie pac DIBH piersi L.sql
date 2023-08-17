;WITH piersi as (
select * from PatCPlan PCPlan
WHERE PCPlan.Tx_Intent LIKE '%247%' -- zawiera procedurê 92.247
AND 
(PCPlan.Protocol LIKE '%moty%'  -- zawiera typowe nazwy planu piers lub motyl
OR PCPlan.Protocol LIKE '%piersL%')
),
Sit as (
select * from Site st
WHERE st.Technique LIKE '%247%'
AND 
st.Dose_Ttl = 4250 --total dose wpisany jako 4250cGy
and st.Version = 0
)
SELECT pat.Last_Name, pat.First_Name, id.IDA, pie.Tx_Intent, pie.Protocol, sit.Site_Name, CONVERT(varchar,pie.Eff_DtTm,111) data
FROM piersi pie
JOIN Sit ON sit.Pat_ID1 = pie.Pat_ID1
JOIN Patient pat on pat.Pat_ID1 = pie.Pat_ID1
JOIN ident id on id.Pat_ID1 = pie.Pat_ID1
WHERE sit.Site_Name NOT LIKE '%praw%' -- usuwa wyniki w których site name zawiera s³owo prawa
ORDER BY IDA