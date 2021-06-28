#!/usr/bin/env bash
. bin/common.sh

has_otomi='false'
[ -f $ENV_DIR/bin/otomi ] && has_otomi='true'

bin/gen-sops.sh

function generate_loose_schema() {
  local schema_path=".vscode/values-schema.yaml"
  local targetPath="$ENV_DIR/$schema_path"
  local sourcePath="$PWD/values-schema.yaml"
  yq r -j "${sourcePath}" | jq "del(.. | .required?)" | yq r --prettyPrint - >"$targetPath"
  # yq d $sourcePath '**.required.' | yq d - 'properties.toolsVersion' | yq d - 'properties.cluster' >$targetPath
  # also put a copy in the .values folder for local hinting of .demo/env/*.yaml files:
  [ "$PWD" != "/home/app/stack" ] && [ ! -f $PWD/$schema_path ] && cp $targetPath .values
  echo "Stored YAML schema at: $targetPath"
}

# install CLI
bin_path="$ENV_DIR/bin"
mkdir -p $bin_path &>/dev/null

img="otomi/core:$(otomi_image_tag)"
echo "Installing artifacts from $img"
set +e
for f in 'aliases' 'colors.sh' 'common.sh' 'otomi'; do
  cp $PWD/bin/$f $bin_path/ &>/dev/null
done
set -e
cp -r $PWD/.values/.vscode $ENV_DIR/
generate_loose_schema

for file in '.gitattributes' '.sops.yaml.sample' '.secrets.sample'; do
  f=${file%.sample}
  [ ! -f $ENV_DIR/$f ] && cp $PWD/.values/$file $ENV_DIR/
done
for f in '.gitignore' '.prettierrc.yml' 'README.md'; do
  cp $PWD/.values/$f $ENV_DIR/
done
if [ ! -d $ENV_DIR/env ]; then
  if [ -z "$PROFILE" ]; then
    # we want the empty skeleton files
    cp -r $PWD/.values/env $ENV_DIR/
  else
    # we asked for a profile
    readonly common_profile_path=$PWD/profiles/common/env
    readonly profile_path=$PWD/profiles/$PROFILE/env

    echo "No files found in "$ENV_DIR/env". Installing example files from profile $PROFILE"
    cp -r $common_profile_path $ENV_DIR
    cp -r $profile_path $ENV_DIR
  fi
fi
git init $ENV_DIR
cp -f $PWD/bin/hooks/pre-commit $ENV_DIR/.git/hooks/
# to accomodate sops plugin in vscode:
[ "${GCLOUD_SERVICE_KEY-}" != '' ] && echo $GCLOUD_SERVICE_KEY | jq '.' >$ENV_DIR/gcp-key.json
readonly secrets_file="$ENV_DIR/env/secrets.settings.yaml"
if [ -f "$secrets_file" ] && [ "$(cat $secrets_file | yq r - 'otomi.pullSecret')" != '' ]; then
  echo "Copying Otomi Console setup"
  cp -rf $PWD/docker-compose $ENV_DIR/
  cp -f $PWD/core.yaml $ENV_DIR/
  cp -f $PWD/docker-compose.yml $ENV_DIR/
fi
if [ "$has_otomi" = 'false' ]; then
  echo "You can now use otomi CLI"
  echo "Start by sourcing aliases:"
  echo ". bin/aliases"
fi
echo "Done!"
