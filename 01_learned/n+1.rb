# N + 1 queries reduction:
# source: https://semaphoreci.com/blog/2017/08/09/faster-rails-eliminating-n-plus-one-queries.html

# =============
# Regular query
# =============
builds = Build.order(:finished_at).limit(10)

builds.each do |build|
  puts "#{build.branch.name} build number #{build.number}"
end

# One query for loading the builds
SELECT * FROM "builds" ORDER BY "finished_at" ASC LIMIT 10

# and N queries for loading the branch in each iteration
SELECT * FROM "branches" WHERE "id" = 11
SELECT * FROM "branches" WHERE "id" = 13
...
SELECT * FROM "branches" WHERE "id" = 119

# =============
# Eager Loading
# =============

builds = Build.order(:finished_at).includes(:branches).limit(10)

builds.each do |build|
  puts "#{build.branch.name} build number #{build.number}"
end

# One query for loading the builds
SELECT * FROM "builds" ORDER BY "finished_at" ASC LIMIT 10

# and another one for loading the associated branches
SELECT * FROM "branches" WHERE "id" IN (11, 13, 15, 17, 19, 111, 113, 115, 117, 119)