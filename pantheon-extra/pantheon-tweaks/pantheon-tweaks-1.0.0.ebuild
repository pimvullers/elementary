# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="A system settings panel for the Pantheon DE"
HOMEPAGE="https://github.com/pantheon-tweaks/pantheon-tweaks"
SRC_URI="https://github.com/pantheon-tweaks/pantheon-tweaks/archive/refs/tags//${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:=
	dev-libs/libgee:0.8
	pantheon-base/switchboard
	!pantheon-extra/elementary-tweaks
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
