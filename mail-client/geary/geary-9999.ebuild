# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils git-2

DESCRIPTION="A lightweight, easy-to-use, feature-rich email client"
HOMEPAGE="http://redmine.yorba.org/projects/geary/wiki"
EGIT_REPO_URI="git://yorba.org/geary"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-db/sqlheavy-0.1.1:0.1
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libgee
	dev-libs/libunique:3
	dev-libs/gmime:2.6
	gnome-base/libgnome-keyring
	net-libs/webkit-gtk:3
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.18
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=(AUTHORS MAINTAINERS)
}

src_configure() {	
	local mycmakeargs=(
		-DDESKTOP_UPDATE=OFF
		-DGSETTINGS_COMPILE=OFF
		-DICON_UPDATE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.18)"
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

