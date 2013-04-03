# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit fdo-mime gnome2-utils cmake-utils

DESCRIPTION="A lightweight, easy-to-use, feature-rich email client"
HOMEPAGE="http://redmine.yorba.org/projects/geary/wiki"
SRC_URI="http://yorba.org/download/${PN}/0.2/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-db/sqlheavy-0.1.1:0.1
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libgee:0
	dev-libs/libunique:3
	dev-libs/gmime:2.6
	gnome-base/libgnome-keyring
	media-libs/libcanberra
	net-libs/webkit-gtk:3
	x11-libs/gtk+:3
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS=(AUTHORS MAINTAINERS)
}

src_prepare() {
	epatch "${FILESDIR}/fix-granite-0.1.1.patch"

	base_src_prepare
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

