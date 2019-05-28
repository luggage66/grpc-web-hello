#! /usr/bin/env bash
mkdir -p lib

# all .proto file in proto
# except google/api (redundant when using pbjs and gives errors)
# find ../../proto ! \( -path "*/google/api/*" \) -name "*.proto" | xargs -J {} npx pbjs {} -t ./custom-target.js -o out.json

# find ../../proto -name "*.proto" | xargs -J {} protoc --json_out=protoc_json --proto_path ../../proto {}

# .proto -> .js
find ./proto  ! \( -path "*/google/api/*" \)  -name "*.proto" | xargs -J {} npx pbjs {} \
  -t static-module \
  --es6 \
  -w es6 \
  -o lib/generated.js

# .js (with type comments) -> .d.ts
npx pbts lib/generated.js \
  -o src/generated.d.ts

cp src/generated.d.ts lib/generated.d.ts
