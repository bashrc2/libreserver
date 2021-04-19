APP=libreserver
VERSION=4.00
RELEASE=1
PREFIX?=/usr/local

all:
debug:
translations:
	bash -c "./translate make"
rmtranslations:
	bash -c "./translate remove"
alltranslations:
	bash -c "./translate translations"
tidy:
	./tidyup src/*
source:
	rm -f \#* \.#* src/*~
	rm -fr deb.*
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc
	cd .. && mv ${APP} ${APP}-${VERSION} && tar -zcvf ${APP}_${VERSION}.orig.tar.gz --exclude .git ${APP}-${VERSION}/ && mv ${APP}-${VERSION} ${APP}
install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}/usr/share/${APP}/base
	mkdir -p ${DESTDIR}/usr/share/${APP}/apps
	mkdir -p ${DESTDIR}/usr/share/${APP}/android-app
	mkdir -p ${DESTDIR}/usr/share/${APP}/webadmin
	mkdir -p ${DESTDIR}/usr/share/${APP}/utils
	mkdir -p ${DESTDIR}/usr/share/${APP}/avatars
	mkdir -p ${DESTDIR}/etc/${APP}
	cp src/${APP} ${DESTDIR}${PREFIX}/bin
	rm -f ${DESTDIR}${PREFIX}/bin/${APP}-*
	cp -r image_build/* ${DESTDIR}/etc/${APP}
	cp img/avatars/* ${DESTDIR}/usr/share/${APP}/avatars
	cp src/view-x-face ${DESTDIR}${PREFIX}/bin
	cp src/muttquote-x-face ${DESTDIR}${PREFIX}/bin
	cp src/* ${DESTDIR}${PREFIX}/bin
	cp src/${APP}-mesh-batman ${DESTDIR}${PREFIX}/bin/batman
	cp src/${APP}-backup-local ${DESTDIR}${PREFIX}/bin/backup
	cp src/${APP}-backup-local ${DESTDIR}${PREFIX}/bin/backup2friends
	cp src/${APP}-restore-local ${DESTDIR}${PREFIX}/bin/restore
	rm -f ${DESTDIR}/usr/share/${APP}/base/*
	rm -f ${DESTDIR}/usr/share/${APP}/apps/*
	rm -f ${DESTDIR}/usr/share/${APP}/utils/*
	mv ${DESTDIR}${PREFIX}/bin/${APP}-base-* ${DESTDIR}/usr/share/${APP}/base
	mv ${DESTDIR}${PREFIX}/bin/${APP}-app-* ${DESTDIR}/usr/share/${APP}/apps
	mv ${DESTDIR}${PREFIX}/bin/${APP}-utils-* ${DESTDIR}/usr/share/${APP}/utils
	mkdir -m 755 -p ${DESTDIR}${PREFIX}/share/man/man1
	cp man/${APP}.1.gz ${DESTDIR}${PREFIX}/share/man/man1
	rm ${DESTDIR}${PREFIX}/share/man/man1/${APP}*.1.gz
	cp man/*.1.gz ${DESTDIR}${PREFIX}/share/man/man1
	cp man/${APP}-backup-local.1.gz ${DESTDIR}${PREFIX}/share/man/man1/backup.1.gz
	cp man/${APP}-restore-local.1.gz ${DESTDIR}${PREFIX}/share/man/man1/restore.1.gz
	cp img/android-app/*.png ${DESTDIR}/usr/share/${APP}/android-app
	cp -r webadmin/* ${DESTDIR}/usr/share/${APP}/webadmin
	chown -R root: /usr/share/${APP}
	chown root: /usr/local/bin/${APP}*
	chmod -R +r /usr/share/${APP}
#	bash -c "./translate install"
	cp src/${APP}-email-remove-html /usr/bin/remove_html
	mkdir -p ${DESTDIR}/etc/share/distro-info
	/usr/local/bin/${APP}-prepare-scripts
uninstall:
	rm -f ${PREFIX}/share/${APP}_*.png
	rm -f ${PREFIX}/share/man/man1/backup.1.gz
	rm -f ${PREFIX}/share/man/man1/restore.1.gz
	rm -f ${PREFIX}/share/man/man1/${APP}*.1.gz
	rm -rf ${PREFIX}/share/${APP}
	rm -rf /usr/share/${APP}
	rm -f ${PREFIX}/bin/${APP}*
	rm -f ${PREFIX}/bin/meshavahi
	rm -f ${PREFIX}/bin/backup
	rm -f ${PREFIX}/bin/backup2friends
	rm -f ${PREFIX}/bin/restore
	rm -f ${PREFIX}/bin/restorefromfriend
	rm -f ${PREFIX}/bin/batman
	rm -rf /etc/${APP}
	rm -f ${PREFIX}/bin/control
	rm -f ${PREFIX}/bin/controluser
	rm -f ${PREFIX}/bin/addremove
	rm -f ${PREFIX}/bin/view-x-face
	rm -f ${PREFIX}/bin/muttquote-x-face
	rm -f /usr/bin/remove_html
	bash -c "./translate uninstall"
clean:
	rm -f \#* \.#* src/*~ tests/*~ doc/EN/*~ website/EN/*~ *~ gemini/EN/*~ image_build/*~
	rm -f webadmin/*~ webadmin/EN/*~ IoT/*~ man/*~
	rm -fr deb.*
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc
