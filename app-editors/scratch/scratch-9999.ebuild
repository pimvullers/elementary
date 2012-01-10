# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="Simple text editor adhering to the Elementary HIG"
HOMEPAGE="https://launchpad.net/scratch"
EBZR_REPO_URI="lp:scratch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0
	gnome-base/gconf
	x11-libs/gtk+:3
	x11-libs/gtksourceview:3.0
	x11-libs/granite"
DEPEND="${RDEPEND}
	|| (
		dev-lang/vala:0.14
		dev-lang/vala:0.12
	)
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( COPYING README )
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.14 valac-0.12 | head -n1)"
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
	gnome2_schemas_update --uninstall
}

