# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson

DESCRIPTION="Default settings for the Pantheon Desktop Environment"
HOMEPAGE="https://github.com/elementary/default-settings"
SRC_URI="https://github.com/elementary/default-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	x11-themes/elementary-icons-theme
	x11-themes/elementary-sound-theme
	x11-themes/elementary-theme
	x11-themes/elementary-wallpapers
	media-fonts/open-sans
	media-fonts/roboto
	pantheon-base/pantheon-settings-daemon
"

S="${WORKDIR}/default-settings-${PV}"

src_prepare() {
	eapply_user

	eapply "${FILESDIR}/6.0.0-drop_test_page.patch"
}

src_configure() {
	local emesonargs=(
		-Dappcenter-flatpak=false
	)
	meson_src_configure
}


pkg_preinst() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_savelist
}

pkg_postinst() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}

pkg_postrm() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}
