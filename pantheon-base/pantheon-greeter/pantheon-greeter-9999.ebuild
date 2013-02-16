# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="Pantheon Login Screen for LightDM"
HOMEPAGE="https://launchpad.net/pantheon-greeter"
EBZR_REPO_URI="lp:pantheon-greeter"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/libindicator:3
	media-libs/clutter-gtk:1.0
	x11-libs/granite
	x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2"
DEPEND="${DEPEND}
	dev-lang/vala:0.18
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.18)"
	)

	cmake-utils_src_configure
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

