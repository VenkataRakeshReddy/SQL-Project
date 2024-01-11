use ipl;
select * from ipl_bidder_details;
select * from ipl_bidder_points;
select * from ipl_bidding_details;
select * from ipl_match;
select * from ipl_match_schedule;
select * from ipl_player;
select * from ipl_stadium;
select * from ipl_team;
select * from ipl_team_players;
select * from ipl_team_standings;
select * from ipl_tournament;
select * from ipl_user;
-- 1. Show the percentage of wins of each bidder in the order of highest to lowest percentage.
select b.bidder_id,b.bidder_name,count(if(a.bid_status='Won',1,null)) as win,
count(a.bidder_id) as total,round(count(if(a.bid_status='Won',1,null))/count(a.bidder_id)*100,2) as percentage 
from ipl_bidding_details a
join ipl_bidder_details b 
on a.bidder_id = b.bidder_id
group by b.bidder_name,b.bidder_id order by percentage desc;

-- 2. Display the number of matches conducted at each stadium with stadium name, city from the database.
select a.stadium_id,a.stadium_name,a.city,count(b.stadium_id)
from ipl_stadium a
join ipl_match_schedule b
on a.stadium_id = b.stadium_id
group by a.stadium_id,a.stadium_name,a.city;

-- 3. In a given stadium, what is the percentage of wins by a team which has won the toss?
select * from ipl_match;
select * from ipl_match_schedule;
select * from ipl_stadium;
select c.stadium_id,c.stadium_name,c.city,count(if(a.match_winner=a.toss_winner,1,null)) as won,
count(a.toss_winner) as total,round(count(if(a.match_winner=a.toss_winner,1,null))/count(a.toss_winner)*100,2) as percent
from ipl_match a
join ipl_match_schedule b
join ipl_stadium c
on a.match_id=b.match_id and c.stadium_id=b.stadium_id
group by c.stadium_id,c.stadium_name,c.city
order by percent desc;

-- 4. Show the total bids along with bid team and team name.
select * from ipl_team;
select * from ipl_bidding_details;
select a.team_name,b.bid_team,count(bid_team) 
from ipl_team a
join ipl_bidding_details b
on a.team_id=b.bid_team
group by a.team_name,b.bid_team;

-- 5. Show the team id who won the match as per the win details.
select * from ipl_match;
select * from ipl_team;
select b.team_id,b.team_name,a.win_details
from ipl_match a
join ipl_team b
on b.remarks=trim(left(substr(WIN_DETAILS,6),position(' ' in substr(win_details,6))));

-- 6. Display total matches played, total matches won and total matches lost by team along with its team name.
select * from ipl_team;
select * from ipl_team_standings;
select a.team_id,a.team_name,sum(b.matches_won) as won,sum(b.matches_lost) as lost,sum(matches_played) as total
from  ipl_team a
join ipl_team_standings b
on a.team_id=b.team_id
group by a.team_id,a.team_name;
-- 7. Display the bowlers for Mumbai Indians team.
select * from ipl_team;
select * from ipl_team_players;
select * from ipl_player;
select c.team_name,a.player_name,b.player_role 
from ipl_player a
join ipl_team_players b
join ipl_team c
on a.player_id=b.player_id and c.team_id=b.team_id
where c.team_name = 'Mumbai Indians' and b.player_role = 'bowler';

select a.*,b.* from ipl_team_players a
join ipl_player b
on a.player_id=b.player_id;
 
 -- 8. How many all-rounders are there in each team, Display the teams with more than 4 all-rounder in descending order
 select * from ipl_team_players; 
 select * from ipl_team;
 
 select a.team_id,a.team_name,count(if(b.player_role='All-Rounder',1,null)) as total_allrounder
 from ipl_team a
 join ipl_team_players b
 on a.team_id=b.team_id
 group by a.team_id,a.team_name
 having total_allrounder >=4
 order by total_allrounder desc;