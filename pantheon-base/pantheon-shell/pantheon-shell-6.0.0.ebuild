# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Pantheon DE shell"
HOMEPAGE="https://github.com/elementary/session-settings"
SRC_URI="https://github.com/elementary/session-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE="accessibility"

DEPEND=""
RDEPEND="${DEPEND}
	accessibility? ( app-accessibility/orca )
	gnome-base/gnome-session
	gnome-base/gnome-settings-daemon
	gnome-base/gsettings-desktop-schemas
	pantheon-base/applications-menu
	>=pantheon-base/wingpanel-3.0.0
	pantheon-extra/pantheon-agent-polkit
	x11-misc/plank
	>=x11-wm/gala-6.0.0
"

PDEPEND="
	pantheon-base/pantheon-settings
"

S="${WORKDIR}/session-settings-${PV}"


src_prepare() {
	eapply_user

	eapply "${FILESDIR}/${PV}-fix_access_deps.patch"
}

src_configure() {
	local emesonargs=(
		-Ddetect-program-prefixes=false
		-Daccessibility=$(usex accessibility true false)
	)
	meson_src_configure
}
