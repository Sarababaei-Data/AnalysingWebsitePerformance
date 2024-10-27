select *
from website_pageviews
where website_pageview_id  < 1000;

select 
pageview_url,
count(distinct website_pageview_id) as pvs
from website_pageviews
where website_pageview_id  < 1000
group by 1;
-- ////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Assignment1: Finding top Pages

select 
pageview_url,
count(distinct website_pageview_id) as pvs
from website_pageviews
where created_at < '2012-06-09'
group by
	pageview_url;
-- home pasge is more volume in visiting

-- ////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Assignment2: Finding top Entery Pages
-- step1: find the pageview for each session
-- step2: find the url customer sae on that first pageview

select *
from website_pageviews
where created_at < '2012-06-12';

create temporary table first_pv_per_sissions
select 
website_session_id,
min(website_pageview_id) as first_pv
from website_pageviews
where created_at < '2012-06-12'
group by website_session_id;

select * from first_pv_per_sissions;

select 
	website_pageviews.pageview_url as landingPage,
	count(distinct first_pv_per_sissions.website_pageview_id)  AS session_hitting_pages
from first_pv_per_sissions
left join website_pageviews
	on first_pv_per_sissions.first_pv = website_pageviews.website_pageview_id
group by website_pageviews.pageview_url

-- ////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
