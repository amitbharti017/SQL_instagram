-- 1) Find the 5 oldest users? We want to reward our users who have been around the longest

SELECT * FROM users
ORDER BY created_at
LIMIT 5;

-- 2)What day of the week do most users register on? So we can schedule an ad campgain.

SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

-- 3)Find the users who have never posted a photo? We want to target our inactive users with an email campaign.

SELECT users.username FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- 4)Who WON? We're running a new contest to see who can get the most likes on a single photo.

SELECT 
	username,
	photos.id,
	photos.image_url,
    COUNT(*) AS num_likes
FROM photos
INNER JOIN likes ON likes.photo_id = photos.id
INNER JOIN users ON photos.user_id = users.id
GROUP BY photo_id
ORDER BY num_likes DESC
LIMIT 1;

-- 5)How many times does the average user post?

SELECT 
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;

-- 6)What are the top 5 most commonly used hashtags? A brand wants to know which hashtags to use in a post.

SELECT tag_name,COUNT(*) AS num_tag FROM photo_tags
INNER JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY num_tag DESC
LIMIT 5;
