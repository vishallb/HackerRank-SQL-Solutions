/*Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of 
hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a 
full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.*/

# solution
SELECT CONCAT(Hackers.hacker_id, ' ', Hackers.name) AS hacker_info
FROM Hackers
INNER JOIN (
    SELECT S.hacker_id, COUNT(*) AS full_scores
    FROM Submissions S
    INNER JOIN Challenges C ON S.challenge_id = C.challenge_id
    INNER JOIN Difficulty D ON C.difficulty_level = D.difficulty_level
    WHERE S.score = D.score
    GROUP BY S.hacker_id
    HAVING full_scores > 1
) AS FullScorers
ON Hackers.hacker_id = FullScorers.hacker_id
ORDER BY FullScorers.full_scores DESC, Hackers.hacker_id ASC;
