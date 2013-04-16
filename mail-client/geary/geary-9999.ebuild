# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit fdo-mime gnome2-utils vala cmake-utils git-2

DESCRIPTION="A lightweight, easy-to-use, feature-rich email client"
HOMEPAGE="http://redmine.yorba.org/projects/geary/wiki"
EGIT_REPO_URI="git://yorba.org/geary"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="nls"

CDEPEND="
	app-crypt/libsecret
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libgee:0
	dev-libs/libunique:3
	dev-libs/gmime:2.6
	>=gnome-base/libgnome-keyring-3.2.2
	media-libs/libcanberra
	net-libs/webkit-gtk:3
	>=x11-libs/gtk+-3.4.0:3
	x11-libs/libnotify"
RDEPEND="${CDEPEND}
	gnome-base/gsettings-desktop-schemas"
DEPEND="${CDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS=(AUTHORS MAINTAINERS)
}

src_prepare() {
	use nls || sed -i 's#add_subdirectory(po)##' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {	
	local mycmakeargs=(
		-DDESKTOP_UPDATE=OFF
		-DGSETTINGS_COMPILE=OFF
		-DICON_UPDATE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

