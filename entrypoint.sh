

case "${GITHUB_EVENT_NAME}" in
  release)
    mkdir hugo-eureka-starters-deploy
    git clone https://${INPUT_TARGET_USERNAME}:${INPUT_TARGET_TOKEN}@${INPUT_TARGET_URL#https://} hugo-eureka-starters-deploy
    cd hugo-eureka-starters-deploy
    rm -rf config
    rm -rf content
    cp -r ../exampleSite/config config
    cp -r ../exampleSite/content content
    git config --global user.name ${INPUT_GIT_USERNAME}
    git config --global user.email ${INPUT_GIT_EMAIL}
    git add .
    echo ${GITHUB_REF}
    echo ${GITHUB_REF##/}
    git commit -m "refactor: upgrade to hugo eureka ${GITHUB_REF##/}"
    git tag ${GITHUB_REF}
    git push --all origin
    git push -f --tags origin
    ;;
  *)
    break
    ;;
esac