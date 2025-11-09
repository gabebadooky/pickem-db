
SELECT * FROM USERS; -- 17
SELECT * FROM PICKS WHERE USER_ID = 17;

select * from GET_GAMES_VW WHERE WEEK = 9;

SELECT * FROM GAMES WHERE LEAGUE = 'CFB' AND WEEK = 9 AND (
	GAME_ID LIKE '%panthers%'		-- kennesaw-state-owls-at-florida-international-panthers
	OR GAME_ID LIKE '%lou%tech%'	-- western-kentucky-hilltoppers-at-louisiana-tech-bulldogs
);


SELECT * FROM PICKS WHERE USER_ID = 17 AND GAME_ID = 'kennesaw-state-owls-at-florida-international-panthers';
UPDATE PICKS
SET TEAM_PICKED = 'florida-international-panthers', PICK_WEIGHT = 'l'
WHERE USER_ID = 17 AND GAME_ID = 'kennesaw-state-owls-at-florida-international-panthers';


SELECT * FROM PICKS WHERE USER_ID = 17 AND GAME_ID = 'western-kentucky-hilltoppers-at-louisiana-tech-bulldogs';
UPDATE PICKS 
SET TEAM_PICKED = 'western-kentucky-hilltoppers', PICK_WEIGHT = 'h'
WHERE USER_ID = 17 AND GAME_ID = 'western-kentucky-hilltoppers-at-louisiana-tech-bulldogs';


