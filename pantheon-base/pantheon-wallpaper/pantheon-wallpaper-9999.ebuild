# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit gnome2-utils vala cmake-utils bzr

DESCRIPTION="Elementary's nautilus-free wallpaper solution"
HOMEPAGE="https://launchpad.net/pantheon-wallpaper"
EBZR_REPO_URI="lp:pantheon-wallpaper"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

CDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0
	x11-libs/granite
	x11-libs/gtk+:3"
RDEPEND="${CDEPEND}
	x11-themes/elementary-wallpapers"
DEPEND="${CDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS="AUTHORS COPYING COPYRIGHT"
}

src_prepare() {
	# Set a default background
	sed -f "${FILESDIR}/${PN}-default.sed" -i org.pantheon.wallpaper.gschema.xml

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# Contractor already provides a wallpaper contract
	rm -r "${ED}/usr/share/contractor"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

