% read data
A = csvread("ratings_trimmed.csv", 1, 0);
movie_genre = csvread("movies_trimmed.csv", 1, 1)';

% constants
NUM_OF_RATINGS = 16;
NUM_OF_GENRES = 18;
NUM_OF_USERS = 5;
% temp vectors
sum = zeros(1, NUM_OF_GENRES);
cnt = zeros(1, NUM_OF_GENRES);
user_pref = zeros(NUM_OF_USERS, NUM_OF_GENRES);

prevuid = A(1,1);
for i = 1:NUM_OF_RATINGS
    uid = A(i,1);
    
    if( uid == prevuid )
        sum = sum + A(i,3)*A(i, 4:4 + NUM_OF_GENRES - 1);
        cnt = cnt + A(i, 4:4 + NUM_OF_GENRES - 1);
    else
        for j = 1:NUM_OF_GENRES
            user_pref(prevuid,j) = sum(1,j) / cnt(1,j);
        end
        prevuid = A(i,1);
        
        % initialize temp vectors
        sum = zeros(1, NUM_OF_GENRES);
        cnt = zeros(1, NUM_OF_GENRES);
        
        sum = sum + A(i,3)*A(i, 4:4 + NUM_OF_GENRES - 1);
        cnt = cnt + A(i, 4:4 + NUM_OF_GENRES - 1);
    end
        
end

for j = 1:NUM_OF_GENRES
	user_pref(prevuid,j) = sum(1,j) / cnt(1,j);
end

user_pref(isnan(user_pref)) = 0;
user_movie_pref = user_pref * movie_genre;
