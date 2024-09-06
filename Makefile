postgres:
	docker run --name postgres16 -p 4233:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine
createdb:
	docker exec -it postgres16 createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres16 dropdb simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:4233/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:4233/simple_bank?sslmode=disable" -verbose down
startcontainer:
	docker start postgres16
stopcontainer:
	docker stop postgres16
sqlc:
	sqlc generate
test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown startcontainer stopcontainer sqlc test