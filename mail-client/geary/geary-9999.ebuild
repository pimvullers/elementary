# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/geary/geary-0.3.1.ebuild,v 1.2 2013/05/30 13:45:08 hasufell Exp $

# REMINDER: next release probably swaps gnome-keyring for libsecret-1

EAPI=5

VALA_MIN_API_VERSION=0.17

inherit eutils fdo-mime gnome2-utils vala cmake-utils git-2

DESCRIPTION="A lightweight, easy-to-use, feature-rich email client"
HOMEPAGE="http://www.yorba.org/projects/geary/"
EGIT_REPO_URI="git://yorba.org/geary"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="ayatana nls"

CDEPEND="
	app-crypt/libsecret
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libgee:0
	dev-libs/libunique:3
	dev-libs/gmime:2.6
	>=gnome-base/libgnome-keyring-3.2.2
	media-libs/libcanberra
	net-libs/webkit-gtk:3[introspection]
	>=x11-libs/gtk+-3.6.0:3[introspection]
	x11-libs/libnotify
	ayatana? ( dev-libs/libindicate:3 )"
RDEPEND="${CDEPEND}
	gnome-base/gsettings-desktop-schemas
	nls? ( virtual/libintl )"
DEPEND="${CDEPEND}
	nls? ( sys-devel/gettext )
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS MAINTAINERS README NEWS THANKS )
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-{unity,cflags}.patch

	local i
	if use nls ; then
		if [[ -n "${LINGUAS+x}" ]] ; then
			for i in $(cd po ; echo *.po) ; do
				if ! has ${i%.po} ${LINGUAS} ; then
					sed -i -e "s/\s${i%.po}$//" po/CMakeLists.txt || die
					rm po/${i} || die
				fi
			done
		fi
	else
		sed -i -e 's#add_subdirectory(po)##' CMakeLists.txt || die
	fi

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDESKTOP_UPDATE=OFF
		-DGSETTINGS_COMPILE=OFF
		-DICON_UPDATE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		$(cmake-utils_use_with ayatana UNITY)
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	elog "For libnotify sounds you will need"
	elog "\"alsa\" or \"pulseaudio\" useflag of media-libs/libcanberra"
	elog "enabled."

	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
