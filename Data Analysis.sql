-- Most Successful Team: Identifying the team with the most wins
SELECT winner, COUNT(*) AS wins
FROM ipl_matches
GROUP BY winner
ORDER BY wins DESC;

-- Top Players: Identifying the players with the most 'Player of the Match' awards
SELECT player_of_match, COUNT(*) AS awards
FROM ipl_matches
GROUP BY player_of_match
ORDER BY awards DESC;

-- Influence of Toss: Checking how often the toss winner wins the match
SELECT toss_winner, COUNT(*) AS total,
SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS won_after_toss_win
FROM ipl_matches
GROUP BY toss_winner;

-- Preferred Toss Decision: Understanding whether teams prefer to bat or bowl after winning the toss
SELECT YEAR(date) AS year, toss_decision, COUNT(*) AS count
FROM ipl_matches
GROUP BY YEAR(date), toss_decision
ORDER BY YEAR(date), toss_decision;

-- Performance at Different Venues: How teams perform at various venues
SELECT venue, team1 AS team, COUNT(*) AS games_played,
SUM(CASE WHEN winner = team1 THEN 1 ELSE 0 END) AS wins
FROM ipl_matches
GROUP BY venue, team1
UNION ALL
SELECT venue, team2, COUNT(*) AS games_played,
SUM(CASE WHEN winner = team2 THEN 1 ELSE 0 END) AS wins
FROM ipl_matches
GROUP BY venue, team2
ORDER BY venue, wins DESC;

-- Impact of Match Venue: Does playing at a neutral venue affect the outcome of matches?
SELECT neutral_venue, COUNT(*) AS total_matches,
SUM(CASE WHEN result = 'wickets' THEN 1 ELSE 0 END) AS won_by_wickets,
SUM(CASE WHEN result = 'runs' THEN 1 ELSE 0 END) AS won_by_runs
FROM ipl_matches
GROUP BY neutral_venue;

-- Close Matches: Identifying matches that were decided in the last over or by a narrow margin
SELECT COUNT(*) AS close_matches
FROM ipl_matches
WHERE (result_margin < 10 AND result = 'runs')
OR (result_margin <= 2 AND result = 'wickets');

-- Seasonal Analysis for Teams: Which teams performed best in each season
SELECT YEAR(date) AS season, winner, COUNT(*) AS wins
FROM ipl_matches
GROUP BY season, winner
ORDER BY season, wins DESC;

-- Seasonal Analysis for Players: Which players performed best in each season
SELECT YEAR(date) AS season, player_of_match, COUNT(*) AS awards
FROM ipl_matches
GROUP BY season, player_of_match
ORDER BY season, awards DESC;
