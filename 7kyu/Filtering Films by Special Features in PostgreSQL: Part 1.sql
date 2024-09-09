-- Description
-- function twoSum(numbers, target) {
--   for (let i = 0; i < numbers.length - 1; i++) {
--     for (let j = i + 1; j < numbers.length; j++) {
--       if (numbers[i] + numbers[j] === target) {
--         return [i, j];
--       }
--     }
--   }
--   return [];
-- }
SELECT
    film_id,
    title,
    special_features
FROM
    film
WHERE
    'Trailers' = Any (special_features)
    AND 'Deleted Scenes' = Any (special_features)
ORDER BY
    title,
    film_id ASC;