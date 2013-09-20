.PHONY: all build-smack build-asmack clean javadoc test it eclipse install deploy

all: test install

build-smack: smack/target
build-asmack: asmack/build

init:
	git submodule update --init --recursive

smack/target:
	$(MAKE) -C smack build-smack

asmack/build:
	cd asmack && ./build.bash -r ../smack -p -a 8

clean:
	$(MAKE) -C smack clean
	rm -Rf asmack/build

test:
	$(MAKE) -C smack unit-test

it:
	$(MAKE) -C smack integration-test

javadoc:
	$(MAKE) -C smack javadoc

install: build-smack build-asmack
	@mvn deploy:deploy-file -DpomFile=smack.pom.xml -Dfile=smack/target/smack.jar -Dsources=smack/target/smack-source.jar -Durl=file://${CURDIR}/repository -DcreateChecksum=true
	@mvn deploy:deploy-file -DpomFile=smackx.pom.xml -Dfile=smack/target/smackx.jar -Dsources=smack/target/smackx-source.jar -Durl=file://${CURDIR}/repository -DcreateChecksum=true
	@mvn deploy:deploy-file -DpomFile=smackx-jingle.pom.xml -Dfile=smack/target/smackx-jingle.jar -Dsources=smack/target/smackx-jingle-source.jar -Durl=file://${CURDIR}/repository -DcreateChecksum=true
	@mvn deploy:deploy-file -DpomFile=asmack.pom.xml -Dfile=asmack/build/asmack-android-8.jar -Dsources=asmack/build/asmack-android-8-source.zip -Durl=file://${CURDIR}/repository -DcreateChecksum=true


deploy:
	@# REPO - url of repository to deploy to
	@# REPO_ID - id of repository to deploy to
	@# usage: make REPO="repo" REPO_ID="repoid" deploy
	ifndef REPO
	ifndef REPO_ID
	$(error Usage: make REPO="repo" REPO_ID="repoid" deploy)
	endif
	endif
	@mvn deploy:deploy-file -DpomFile=smack.pom.xml -Dfile=smack/target/smack.jar -Dsources=smack/target/smack-source.jar -Durl=${REPO} -DcreateChecksum=true  -DrepositoryId=${REPO_ID}
	@mvn deploy:deploy-file -DpomFile=smackx.pom.xml -Dfile=smack/target/smackx.jar -Dsources=smack/target/smackx-source.jar -Durl=${REPO} -DcreateChecksum=true  -DrepositoryId=${REPO_ID}
	@mvn deploy:deploy-file -DpomFile=smackx-jingle.pom.xml -Dfile=smack/target/smackx-jingle.jar -Dsources=smack/target/smackx-jingle-source.jar -Durl=${REPO} -DcreateChecksum=true  -DrepositoryId=${REPO_ID}
	@mvn deploy:deploy-file -DpomFile=asmack.pom.xml -Dfile=asmack/build/asmack-android-8.jar -Dsources=asmack/build/asmack-android-8-source.zip -Durl=${REPO} -DcreateChecksum=true  -DrepositoryId=${REPO_ID}