# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="a lightweight ToDo app written in Vala for the elementary project"
HOMEPAGE="https://launchpad.net/ergo"
EBZR_REPO_URI="lp:ergo"

LICENSE="CC0-1.0-Universal"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/granite"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/vala:0.14"

pkg_setup() {
	DOCS=( AUTHORS COPYING COPYRIGHT )
}

src_prepare() {
	# Disable compilation of GSettings schemas, this is handled by this ebuild
	epatch "${FILESDIR}/${PN}-0.1-cmake-gsettings-module.patch"
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE=$(type -p valac-0.14)
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update --uninstall
}

