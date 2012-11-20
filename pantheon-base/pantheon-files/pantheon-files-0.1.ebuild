# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils

DESCRIPTION="A simple, powerful, sexy file manager for the Pantheon desktop"
HOMEPAGE="https://launchpad.net/pantheon-files"
SRC_URI="https://launchpad.net/${PN}/0.x/luna-beta1/+download/${P}-luna-beta1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gvfs nls plugins"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/dbus-glib
	>=dev-libs/glib-2.29.0:2
	x11-libs/granite
	dev-libs/libgee:0
	x11-libs/varka
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/pango
	gvfs? ( gnome-base/gvfs )
	!pantheon-base/marlin"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	S="${WORKDIR}"
	DOCS=( AUTHORS COPYING ChangeLog NEWS README TODO )
}

src_prepare() {
	use nls || sed -i -e 's/add_subdirectory (po)//' CMakeLists.txt
	use plugins || sed -i -e 's/add_subdirectory (plugins)//' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DICON_UPDATE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

